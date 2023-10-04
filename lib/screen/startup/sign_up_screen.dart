import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';

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
                        const Header(title: 'Sign Up'),
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
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,

                                  controller: accountNoController,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.blue,
                                    ),
                                    hintText: "Enter Account No",
                                  ),
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
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.mobile_friendly,
                                      color: Colors.blue,
                                    ),
                                    hintText: "Enter Mobile No",
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
                                        Get.to(OTPScreen());
                                      }
                                    },
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
