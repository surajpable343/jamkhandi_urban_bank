import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/colors_model/pick_colors.dart';
import 'package:jamkhandi_urban_bank/screen/dashboard/main_screen.dart';
import 'package:jamkhandi_urban_bank/screen/startup/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import 'CreatePassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  // final RefernceCode = Get.arguments as String;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 170,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      obscureText: true, // Hide the password input
                                      decoration: const InputDecoration(
                                        hintText: 'Enter Password',
                                        border: InputBorder.none,
                                      ),
                                      validator: (password) {
                                        if (password == null || password.isEmpty) {
                                          return 'Password cannot be empty';
                                        }
                                        // Add more validation rules as needed
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(1),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.lock,
                                  ),
                                  onPressed: () {
                                    // Password visibility toggle logic can be added here
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to( MainScreen());
                        },
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Forgot Password?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
