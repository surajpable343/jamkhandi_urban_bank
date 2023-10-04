import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_connection/API.dart';
import '../../api_connection/network_utils.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/header.dart';
import '../startup/set_password.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
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
                        const Header(title: 'OTP Verification'),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
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
                                    'OTP Code',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 6,
                                  controller: _accountNumberController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.messenger_outlined,
                                      color: Colors.blue,
                                    ),
                                    hintText: "Enter OTP Number",
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "OTP cannot be empty";
                                    } else if (val.length != 6) {
                                      return "Please enter valid OTP";
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
                                      if (formKey.currentState!.validate()) {
                                        // signInUSer();
                                        Get.to(SetPasswordScreen());
                                      }
                                    },
                                    child: _isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            'Submit',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }
}
