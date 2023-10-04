import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/screen/startup/login_screen.dart';
import 'package:jamkhandi_urban_bank/screen/startup/signin_screen.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import '../../decoration/background_decoration.dart';
import 'login_screen_new.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;

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
                        const Header(title: 'Set Password'),
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
                                    'New Password',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),

                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.blue,
                                    ),
                                    hintText: "Enter New Password",
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
                                      return "Please enter valid Password";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
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
                                    'Confirm Password',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),

                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.blue,
                                    ),
                                    hintText: "Confirm Password",
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Confirm Password cannot be empty";
                                    } else if (val.length != 4) {
                                      return "Please enter valid Confirm Password";
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
                                        Get.to(const LoginScreen());
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
