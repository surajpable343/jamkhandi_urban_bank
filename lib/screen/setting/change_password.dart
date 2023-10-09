import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/screen/setting/setting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import '../../colors_model/pick_colors.dart';
import '../../custom_widget/custom_app_bar.dart';
import '../../custom_widget/custom_bottom_bar_small.dart';
import '../../custom_widget/custom_text_widget.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/header.dart';
import '../dashboard/main_screen.dart';
import 'package:flutter/services.dart';

import '../startup/otp_verification.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final OldPasswordController = TextEditingController();
  final NewPasswordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: SafeArea(
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
                      height: 20,
                    ),
                    const Header(title: 'Change Password'),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
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
                                        text: 'Old Password',
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: OldPasswordController,
                                      decoration: buildInputDecoration(
                                        Icons.key,
                                        "Enter Old Password",
                                      ),
                                      textDirection: TextDirection.ltr,
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
                                          return "Please enter a 4-digit Password";
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
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        color: PickColor.lightBlue,
                                      ),
                                      child: CustomTextWidget(
                                        text: 'New Password',
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: OldPasswordController,
                                      decoration: buildInputDecoration(
                                        Icons.key,
                                        "Enter New Password",
                                      ),
                                      textDirection: TextDirection.ltr,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]'),
                                        ),
                                        LengthLimitingTextInputFormatter(4),
                                      ],
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "New Password cannot be empty";
                                        } else if (val.length != 4) {
                                          return "Please enter a 4-digit New Password";
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
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                        color: PickColor.lightBlue,
                                      ),
                                      child: CustomTextWidget(
                                        text: 'Confirm Password',
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: OldPasswordController,
                                      decoration: buildInputDecoration(
                                        Icons.key,
                                        "Enter Confirm Password",
                                      ),
                                      textDirection: TextDirection.ltr,
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
                                          return "Please enter a 4-digit Confirm Password";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  width: double.infinity,
                                  height: 55,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      _showAlertDialog(context);
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
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: const CustomBottomBarSmall(),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Status'),
          content: const Text('Password Change Sucessfully.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.to(SettingScreen());
              },
              child: CustomTextWidget(
                text: "Submit",
                color: PickColor.white,
                fontSize: 14,
              ),
            ),
          ],
        );
      },
    );
    Future<void> _ChangePassword() async {
      setState(() {

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
          var response = await http.post(Uri.parse(API.changePassword), body: {
            "CustomerID": CustomerID,
            "UserID": UserID,
            "AccountNumber": AccountNumber,
            "ReferenceNumber": rrr,
            "DeviceID": deviceId,
            "MobileNumber": MobileNumber,
            "Password": "3ECD84E35A0D83E7C1CDDD09883D4835",
            "NewPassword": "3ECD84E35A0D83E7C1CDDD09883D4835",
          });
          print('Request data: ${response}');
          if (response.statusCode == 200) {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            responseCode = responseData['ResponseCode'];
            responseDesc = responseData['ResponseDesc'];
            MobileNumber = responseData['MobileNumber'];
            AccountNumber = responseData['AccountNumber'];

            print('data: ${response.body}');
            if (responseCode == "91") {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Alert'),
                      content: Text(responseDesc),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Get.to(MainScreen());
                            },
                            child: Text('Ok'))
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

      });
    }
  }
}
