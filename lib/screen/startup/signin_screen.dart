import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jamkhandi_urban_bank/api_connection/network_utils.dart';
import 'package:jamkhandi_urban_bank/custom_widget/custom_text_widget.dart';
import 'package:jamkhandi_urban_bank/decoration/background_decoration.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_connection/API.dart';
import '../../colors_model/pick_colors.dart';
import 'otp_verification.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  var formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  final _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
                  const Header(title: 'Sign In'),
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
                              'Account No',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _accountNumberController,
                            maxLength: 12,
                            keyboardType: TextInputType.number,
                            decoration: buildInputDecoration(
                              Icons.person,
                              "Enter account number",
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                              LengthLimitingTextInputFormatter(12),
                            ],
                            validator: (val) => val == ""
                                ? "Account number cannot be empty"
                                : val?.length != 12
                                    ? "Please enter valid Account number"
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
                                  // signInUSer();
                                  sendOtpRequest(_accountNumberController.text);
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

void sendOtpRequest(String accountNumber) {
  _sendOTPReq(accountNumber);
}

Future<void> _sendOTPReq(String accountNumber) async {
  bool isConnected = await Utils.checkNetworkConnectivity();
  String rrr;
  if (isConnected) {
    Utils.showProgressDialog();
    String responseDesc, responseCode, CustomerName, CustomerID, UserID;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String accountNumber = prefs.getString('accountNumber') ?? '';
    rrr = Utils.generateRRR();
    String deviceId = await Utils.getDeviceId();

    try {
      var response = await http.post(Uri.parse(API.signInUser), body: {
        "AccountNumber": accountNumber,
        "ReferenceNumber": rrr,
        "DeviceID": deviceId,
      });
      print('Request data: ${response}');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        responseCode = responseData['ResponseCode'];
        responseDesc = responseData['ResponseDesc'];

        print('data: ${response.body}');
        if (responseCode == "96") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('AccountNumber', accountNumber);
          prefs.setString('ReferenceNumber', rrr);

          Utils.dismissProgressDialog();
          Get.to(OTPScreen());
        } else {
          // Utils.dismissProgressDialog();
          Map<String, dynamic> responseData = jsonDecode(response.body);
          String responseDesc = responseData['ResponseDesc'];

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       responseDesc,
          //       style: TextStyle(color: Colors.white), // Set the text color
          //     ),
          //     backgroundColor: Colors.red,
          //   ),
          // );
          Get.snackbar(
            "Error",
            responseDesc,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: PickColor.lightBlue,
          );
        }
      } else {
        Utils.dismissProgressDialog();
        Get.snackbar(
          "Error",
          "Server Not responding",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PickColor.lightBlue,
        );
      }
    } catch (error) {
      Utils.dismissProgressDialog();
      // Handle the error here
      print(error);
    }
  } else {
    Utils.dismissProgressDialog();
    print("test");
  }
}
