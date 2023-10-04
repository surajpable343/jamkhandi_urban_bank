import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/header.dart';
import '../dashboard/main_screen.dart';
import '../startup/set_password.dart';

class OTPConfrimationPage extends StatefulWidget {
  @override
  _OTPConfrimationPage createState() => _OTPConfrimationPage();
}

class _OTPConfrimationPage extends State<OTPConfrimationPage> {
  final formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  bool _isLoading = false;
 final RefernceCode = Get.arguments as String;

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      _verifyOTP();
    }
  }

  Future<void> _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    bool isConnected = await Utils.checkNetworkConnectivity();

    if (isConnected) {
      String responseDesc, responseCode;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String MobileNumber = prefs.getString('MobileNumber') ?? '';
      String AccountNumber = prefs.getString('AccountNumber') ?? '';

      String rrr = Utils.generateRRR();
      String deviceId = await Utils.getDeviceId();

      try {
        var response = await http.post(Uri.parse(API.createOtp), body: {
          "AccountNumber": AccountNumber,
          "ReferenceNumber": RefernceCode,
          "DeviceID": deviceId,
          "MobileNumber": MobileNumber,
          "OTP": _accountNumberController.text,
        });
        print('Request data: ${response.body}');
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];
          responseDesc = responseData['ResponseDesc'];
          MobileNumber = responseData['MobileNumber'];
          AccountNumber = responseData['AccountNumber'];

          print('data: ${response.body}');
          if (responseCode == "00") {
            responseCode = responseData['ResponseCode'];
            responseDesc = responseData['ResponseDesc'];
            SharedPreferences pre = await SharedPreferences.getInstance();
            pre.setString("AccountNumber", AccountNumber);
            pre.setString("MobileNumber", MobileNumber);
           // Get.to(SetPasswordScreen(), arguments: RefernceCode);
            mpinRequest();
            print('data: ${response.body}');
          } else {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            String responseDesc = responseData['ResponseDesc'];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  responseDesc,
                  style: TextStyle(color: Colors.white), // Set the text color
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Server Not responding",
                style: TextStyle(color: Colors.white), // Set the text color
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        // Handle the error here
        print(error);
      }
    }

    setState(() {
      _isLoading = false;
    });
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
                                      Icons.person,
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
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _submitForm,
                                    child: _isLoading
                                        ? CircularProgressIndicator()
                                        : const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
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

  void mpinRequest() {
    _ChangemPin();
  }
  Future<void> _ChangemPin() async {
    setState(() {
      _isLoading = true;
    });


    // final RefernceCode = Get.arguments as String;
    bool isConnected = await Utils.checkNetworkConnectivity();

    if (isConnected) {
      String responseDesc, responseCode, CustomerName, CustomerID, UserID;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String MobileNumber = prefs.getString('MobileNumber') ?? '';
      String AccountNumber = prefs.getString('AccountNumber') ?? '';
      CustomerID = prefs.getString('CustomerID') ?? '';
      UserID = prefs.getString('UserID') ?? '';
      String rrr = Utils.generateRRR();
      String deviceId = await Utils.getDeviceId();

      try {
        var response = await http.post(Uri.parse(API.forgetTpin), body: {
          "AccountNumber": AccountNumber,
          "ReferenceNumber": rrr,
          "MobileNumber": MobileNumber,

        });
        print('Request data: ${response}');
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];
          responseDesc = responseData['ResponseDesc'];
          MobileNumber = responseData['MobileNumber'];
          AccountNumber = responseData['AccountNumber'];

          print('data: ${response.body}');
          if (responseCode == "00") {
            showDialog(context: context, builder: (BuildContext context ){
              return AlertDialog(
                title: const Text('Alert'),
                content: Text(responseDesc),
                actions: [
                  ElevatedButton(onPressed: (){
                    Get.to(MainScreen());
                  }, child: Text('Ok'))
                ],
              );
            });
          } else {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            String responseDesc = responseData['ResponseDesc'];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  responseDesc,
                  style: TextStyle(color: Colors.white), // Set the text color
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Server Not responding",
                style: TextStyle(color: Colors.white), // Set the text color
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        // Handle the error here
        print(error);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }
}
