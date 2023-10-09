import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jamkhandi_urban_bank/api_connection/network_utils.dart';
import 'package:jamkhandi_urban_bank/custom_widget/custom_text_widget.dart';
import 'package:jamkhandi_urban_bank/decoration/background_decoration.dart';
import 'package:jamkhandi_urban_bank/model/VerifyOTOModel.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_connection/API.dart';
import '../../api_connection/ApiRepository.dart';
import '../../colors_model/pick_colors.dart';
import '../dashboard/main_screen.dart';
import 'otp_verification.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _accountNumberController =
      TextEditingController();
  var apiRepo = ApiRepository();

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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 55),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 300),
                          SizedBox(
                            child: TextFormField(
                              controller: _accountNumberController,
                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: PickColor.blue,
                                ),
                                hintText: "Enter password",
                                contentPadding: const EdgeInsets.all(10),
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
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                                LengthLimitingTextInputFormatter(4),
                              ],
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Password cannot be empty";
                                } else if (val.length != 4) {
                                  return "Please enter a valid 4-digit password";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (formKey.currentState!.validate()) {
                                // Valid form, initiate login verification
                                sendLoginRequest(_accountNumberController.text);
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: PickColor.blue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Submit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          CustomTextWidget(
                            onClick: () =>
                                _forgetPassword(_accountNumberController.text),
                            text: 'Forgot Password?',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: PickColor.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(IconData icons, String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.all(10),
      prefixIcon: Container(
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

  void sendLoginRequest(String accountNumber) {
    _loginVerification(accountNumber);
  }

  Future<void> _loginVerification(String accountNumber) async {
    bool isConnected = await Utils.checkNetworkConnectivity();
    if (isConnected) {
      Utils.showProgressDialog();
      String responseCode;
      try {
        var verifyOtpRequest = VerifyOTPModel(accountNumber);
        var response = await apiRepo.postApi(verifyOtpRequest, API.login);
        log('data suraj: $response');
        if(response['ResponseCode'] == '20'){
          Utils.dismissProgressDialog();
          Get.to(MainScreen());
        }else {
          Utils.dismissProgressDialog();
        }
       /* var response = await http.post(Uri.parse(API.login), body: {
          "AccountNumber": accountNumber,
          // Add other required parameters here
        });
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];

          if (responseCode == "20") {
            Utils.dismissProgressDialog();
            Get.to(MainScreen());
          } else {
            Utils.dismissProgressDialog();
            Map<String, dynamic> responseData = jsonDecode(response.body);
            String responseDesc = responseData['ResponseDesc'];
          }
        }*/
      } catch (error) {
        // Handle the error here
        print(error);
      }
    } else {
      // Handle case when there is no internet connectivity
    }
  }

  Future<void> _forgetPassword(String accountNumber) async {
    bool isConnected = await Utils.checkNetworkConnectivity();
    if (isConnected) {
      String responseCode;
      try {
        var response = await http.post(Uri.parse(API.login), body: {
          "AccountNumber": accountNumber,
          // Add other required parameters here
        });
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];

          if (responseCode == "20") {
            Get.to(MainScreen());
          } else {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            String responseDesc = responseData['ResponseDesc'];
          }
        }
      } catch (error) {
        // Handle the error here
        print(error);
      }
    } else {
      // Handle case when there is no internet connectivity
    }
  }
}
