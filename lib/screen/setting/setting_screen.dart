import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamkhandi_urban_bank/decoration/background_decoration.dart';
import 'package:jamkhandi_urban_bank/screen/setting/change_password.dart';
import 'package:jamkhandi_urban_bank/screen/setting/ChangeMpin.dart'; // Add the correct import statement here
import 'package:jamkhandi_urban_bank/widgets/footer.dart';
import 'package:jamkhandi_urban_bank/widgets/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import 'OTPConfrimationPage.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BackgroundDecoration.backgroundImage,
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Header(title: 'Setting'),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(const ChangePassword());
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),

                          child: const Center(

                            child: Text(
                              'Change Password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Get.to(const ChangeMpin());
                            },
                            child: const Text(
                              'Change MPIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              sendOtpRequest(context);
                            },
                            child: const Text(
                              'forgot MPin',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Footer(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendOtpRequest(BuildContext context) {
    _sendOTPReq(context);
  }

  Future<void> _sendOTPReq(BuildContext context) async {
    bool isConnected = await Utils.checkNetworkConnectivity();
    String rrr;
    if (isConnected) {
      String responseDesc, responseCode, CustomerName, CustomerID, UserID;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String MobileNumber = prefs.getString('MobileNumber') ?? '';
      String AccountNumber = prefs.getString('AccountNumber') ?? '';
      CustomerID = prefs.getString('CustomerID') ?? '';
      UserID = prefs.getString('UserID') ?? '';
       rrr = Utils.generateRRR();
      String deviceId = await Utils.getDeviceId();

      try {
        var response = await http.post(Uri.parse(API.createOTP), body: {
          "AccountNumber": AccountNumber,
          "ReferenceNumber": rrr,
          "DeviceID": deviceId,
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
            Get.to(OTPConfrimationPage(),arguments: rrr);
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
  }
}
