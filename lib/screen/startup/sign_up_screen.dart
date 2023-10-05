import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:jamkhandi_urban_bank/colors_model/pick_colors.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_connection/API.dart';
import '../../api_connection/network_utils.dart';
import '../../custom_widget/custom_text_widget.dart';
import '../../decoration/background_decoration.dart';
import 'otp_verification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                    height: 100,
                  ),
                  const Header(title: 'Sign Up'),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
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
                              text: 'Account No.',
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: accountNoController,
                            decoration: buildInputDecoration(
                              Icons.person,
                              "Enter account number",
                            ),
                            textDirection: TextDirection.ltr,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              LengthLimitingTextInputFormatter(12),
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Account No cannot be empty";
                              } else if (val.length != 12) {
                                return "Please enter a 12-digit Account No";
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
                              'Mobile No',
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
                              Icons.phone_android,
                              "Enter mobile number",
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Mobile No cannot be empty";
                              } else if (val.length != 10) {
                                return "Please enter a 10-digit Mobile No";
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

                                  _SignUp(accountNoController.text,
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

Future<void> _SignUp(
    String mobileNoController, String? accountNoController) async {
  bool isConnected = await Utils.checkNetworkConnectivity();
  if (isConnected) {
    Utils.showProgressDialog();
    String responseCode;
    String rrr = Utils.generateRRR();
    String AccountNo = mobileNoController.toString();
    String mobileNo = accountNoController.toString();

    String deviceId = await Utils.getDeviceId();
    try {
      var response = await http.post(Uri.parse(API.signInUser), body: {
        "AccountNumber": AccountNo,
        "ReferenceNumber": rrr,
        "DeviceID": deviceId,
        "mobileNo": mobileNo,
      });
      print('Request data: $response');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        responseCode = responseData['ResponseCode'];
        String responseDesc = responseData['ResponseDesc'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('AccountNumber', AccountNo);
        prefs.setString('mobileNo', mobileNo);
        prefs.setString('ReferenceNumber', rrr);

        print('data: ${response.body}');
        if (responseCode == "96") {
          Utils.dismissProgressDialog();
          Get.to(OTPScreen());
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
