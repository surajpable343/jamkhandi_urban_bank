import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/api_connection/network_utils.dart';
import 'package:jamkhandi_urban_bank/decoration/background_decoration.dart';
import 'package:jamkhandi_urban_bank/screen/dashboard/main_screen.dart';
import 'package:jamkhandi_urban_bank/screen/startup/set_password.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_connection/API.dart';
import 'otp_verification.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _MyPageState();
}

class _MyPageState extends State<SignInScreen> {
  var formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  final _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D47A1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BackgroundDecoration.backgroundImage,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView(
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
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.blue,
                                ),
                                child: const Text(
                                  'Account No',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              TextFormField(
                                controller: _accountNumberController,
                                maxLength: 12,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                  hintText: "Enter Account No",
                                ),
                                inputFormatters: [
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
                                    if (formKey.currentState!.validate()) {
                                      // signInUSer();
                                      Get.to(OTPScreen());
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(double.infinity, 50), // Set the fixed size
                                  ),
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                      : const Text(
                                    'Submit',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    textScaleFactor: 1.0, // Ensure text scaling is not applied
                                   ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
