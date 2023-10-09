import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/custom_widget/custom_app_bar.dart';
import 'package:jamkhandi_urban_bank/screen/dashboard/main_screen.dart';
import 'package:pinput/pinput.dart';

import '../../colors_model/pick_colors.dart';
import '../../custom_widget/custom_bottom_bar_small.dart';
import '../../custom_widget/custom_text_widget.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/header.dart';
import '../startup/otp_verification.dart';

class MpinScreen extends StatefulWidget {
  MpinScreen({Key? key}) : super(key: key);

  @override
  State<MpinScreen> createState() => _MpinScreenState();
}

class _MpinScreenState extends State<MpinScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _MpinController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BackgroundDecoration.backgroundImage,
            ),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics(),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Header(title: 'MPIN'),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Colors.blue,
                            ),
                            child: const Text(
                              'MPIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _MpinController,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            decoration: buildInputDecoration(
                              Icons.key,
                              "Enter MPIN",
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (val) => val == ""
                                ? "MPIN cannot be empty"
                                : val?.length != 4
                                    ? "Please enter valid MPIN"
                                    : null,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (formKey.currentState!.validate()) {
                                  _showDialog();
                                }
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
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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


    
    Get.defaultDialog(
      title: "IMPS Fund Transfer  ",
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
              const Text(
                'Transaction Successful',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Material(
                child: Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(MainScreen());
                    },
                    child: CustomTextWidget(
                      text: "Submit",
                      color: PickColor.white,
                      fontSize: 14,
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
