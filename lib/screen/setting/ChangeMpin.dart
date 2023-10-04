import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/header.dart';
import '../dashboard/main_screen.dart';

class ChangeMpin extends StatefulWidget {
  const ChangeMpin({Key? key}) : super(key: key);

  @override
  State<ChangeMpin> createState() => _ChangeMpinState();
}

class _ChangeMpinState extends State<ChangeMpin> {
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      height: 100,
                    ),
                    const Header(title: 'Change MPin'),
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
                                'Enter MPin Password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                hintText: "Enter MPin Password",
                              ),
                            ),
                            SizedBox(
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
                                'Enter MPin Password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mobile_friendly,
                                  color: Colors.blue,
                                ),
                                hintText: "Enter MPin Password",
                              ),
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
                                'Confirm MPin Password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mobile_friendly,
                                  color: Colors.blue,
                                ),
                                hintText: "Confirm MPin Password",
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Change_Mpin();
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
          )
        ]),
      ),
    );
  }

  void Change_Mpin() {
    _ChangeMpin();
  }

    Future<void> _ChangeMpin() async {
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
          var response = await http.post(Uri.parse(API.changemPin), body: {
            "CustomerID": CustomerID,
            "UserID": UserID,
            "AccountNumber": AccountNumber,
            "ReferenceNumber": rrr,
            "DeviceID": deviceId,
            "MobileNumber": MobileNumber,
            "mPIN": "3ECD84E35A0D83E7C1CDDD09883D4835",
            "NewMPIN": "3ECD84E35A0D83E7C1CDDD09883D4835",
          });
          print('Request data: ${response}');
          if (response.statusCode == 200) {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            responseCode = responseData['ResponseCode'];
            responseDesc = responseData['ResponseDesc'];

            print('data: ${response.body}');
            if (responseCode == "91") {
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
