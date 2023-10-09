import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:jamkhandi_urban_bank/colors_model/pick_colors.dart';
import 'package:jamkhandi_urban_bank/custom_widget/custom_bottom_bar_small.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_connection/API.dart';
import '../../api_connection/network_utils.dart';
import '../../custom_widget/custom_app_bar.dart';
import '../../custom_widget/custom_text_widget.dart';
import '../../decoration/background_decoration.dart';
import 'login_screen.dart';
import 'otp_verification.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final accountNoController = TextEditingController();
  final mobileNoController = TextEditingController();

  @override
  void dispose() {
    accountNoController.dispose();
    mobileNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.lightBlue,
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
                  const Header(title: 'set password'),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: PickColor.lightBlue,
                            ),
                            child: CustomTextWidget(
                              text: 'New Password.',
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: accountNoController,
                            decoration: buildInputDecoration(
                              Icons.lock,
                              "Enter password",
                            ),
                            textDirection: TextDirection.ltr,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "password cannot be empty";
                              } else if (val.length != 4) {
                                return "Please enter a 4-digit password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: PickColor.lightBlue,
                            ),
                            child: const Text(
                              'Confirm Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: mobileNoController,
                            decoration: buildInputDecoration(
                              Icons.lock,
                              "Enter confirm password",
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              LengthLimitingTextInputFormatter(4),
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "confirm password cannot be empty";
                              } else if (val.length != 4) {
                                return "Please enter a 4-digit confirm password";
                              }else if (val != accountNoController.text) {
                                return "New password and confirm password do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate the form
                                if (formKey.currentState!.validate()) {
                                  // Form is valid, proceed to OTP screen

                                  setPassword(accountNoController.text,
                                      mobileNoController.text);
                                  // Get.to(OTPScreen());
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
}

InputDecoration buildInputDecoration(IconData icons, String hintText) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: const EdgeInsets.all(10),
    prefixIcon: Container(
      decoration: const BoxDecoration(
        // border: Border(
        //   right: BorderSide(
        //     color: Colors.grey,
        //   ),
        // ),
      ),
      child: Icon(
        icons,
        color: PickColor.blue,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
  );
}

Future<void> setPassword(String password, String NewPassword) async {
  bool isConnected = await Utils.checkNetworkConnectivity();
  if (isConnected) {
    Utils.showProgressDialog();
    String responseCode;
    String passwordOld = password.toString();
    String NewPasswords = NewPassword.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String MobileNumber = prefs.getString('mobileNo') ?? '';
    String AccountNumber = prefs.getString('AccountNumber') ?? '';
    String rrr = prefs.getString('ReferenceNumber') ?? '';

    String deviceId = await Utils.getDeviceId();
    try {
      var response = await http.post(Uri.parse(API.createPassword), body: {
        "AccountNumber": AccountNumber,
        "ReferenceNumber": rrr,
        "DeviceID": deviceId,
        "mobileNo": MobileNumber,
        "Password": passwordOld,
      });
      print('Request data: $response');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        responseCode = responseData['ResponseCode'];
        String responseDesc = responseData['ResponseDesc'];


        print('data: ${response.body}');
        if (responseCode == "001") {
          Utils.dismissProgressDialog();
          Get.to( LoginScreen());
        } else {
          Utils.dismissProgressDialog();
          Map<String, dynamic> responseData = jsonDecode(response.body);
          String responseDesc = responseData['ResponseDesc'];
        }
      } else {}
    } catch (error) {
      // Handle the error here
      print(error);
    }
  } else {}

}
