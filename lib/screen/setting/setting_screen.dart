import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jamkhandi_urban_bank/decoration/background_decoration.dart';
import 'package:jamkhandi_urban_bank/screen/setting/Mpin_Confirmation.dart';
import 'package:jamkhandi_urban_bank/screen/setting/change_password.dart';
import 'package:jamkhandi_urban_bank/screen/setting/ChangeMpin.dart'; // Add the correct import statement here
import 'package:jamkhandi_urban_bank/widgets/footer.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import '../../colors_model/pick_colors.dart';
import '../../custom_widget/custom_app_bar.dart';
import '../../custom_widget/custom_bottom_bar_small.dart';
import '../../custom_widget/custom_text_widget.dart';
import 'OTPConfrimationPage.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => SettingState();
}

class SettingState extends State<SettingScreen> {
  late AnimationController _controller;
  var formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Container(
          decoration: BackgroundDecoration.backgroundImage,
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Header(title: 'Setting'),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const ChangePassword());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                          decoration: const BoxDecoration(
                            color: PickColor.blue,
                          ),
                          child: const Center(
                            child: Text(
                              'Change Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                        decoration: const BoxDecoration(
                          color: PickColor.blue,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(const ChangeMpin());
                            },
                            child: const Text(
                              'Change MPIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                        decoration: const BoxDecoration(
                          color: PickColor.blue,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              _showDialog();
                            },
                            child: const Text(
                              'Forgot MPIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBarSmall(),
    );
  }

  void _showDialog() {
    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: const TextStyle(
        fontSize: 12,
        color: PickColor.black,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: PickColor.lightBlue,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: PickColor.lightBlue,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: PickColor.white,
      ),
    );
    Get.defaultDialog(
      title: "Enter OTP",
      barrierDismissible: false,
      content: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        // height: 100,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                child: Pinput(
                  length: 6,
                  controller: _pinPutController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'),
                    ),
                  ],
                  validator: (otp) {
                    String? msg = otp;
                    if (msg!.length < 6) return 'Pin is incorrect';

                    return null;
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(Mpin_Confiramtion());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PickColor.blue,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: CustomTextWidget(
                      text: 'Submit',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(Mpin_Confiramtion());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PickColor.blue,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: CustomTextWidget(
                      text: 'Cancle',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
