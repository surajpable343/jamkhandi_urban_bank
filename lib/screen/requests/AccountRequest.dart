import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/footer.dart';
import '../../widgets/header.dart';
import 'package:http/http.dart' as http;
class AccountRequest extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              _AccountData(context),
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
                        const Header(title: 'Account Number'),
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [

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

  _AccountData(BuildContext context) {
    _verifyStatementData(context);
  }
  Future<void> _verifyStatementData(BuildContext context) async {

    bool isConnected = await Utils.checkNetworkConnectivity();

    if (isConnected) {
      String responseDesc, responseCode;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String AccountNumber = prefs.getString('AccountNumber') ?? '';
      String rrr = Utils.generateRRR();
      String deviceId = await Utils.getDeviceId();
      String CustomerID = prefs.getString('CustomerID') ?? '';
      String UserID = prefs.getString('UserID') ?? '';

      try {

        var demotest;
        var response = await http.post(Uri.parse(API.signInUser), body: {
          "AccountNumber": AccountNumber,
          "ReferenceNumber": rrr,
          "DeviceID": deviceId,
          "CustomerID": CustomerID,
          "UserID": UserID,

        });
        print('Request data: ${response}');
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];
          responseDesc = responseData['ResponseDesc'];
          AccountNumber = responseData['AccountNumber'];

          print('data: ${response.body}');
          if (responseCode == "00") {
            CustomerID = responseData['CustomerID'];
          //  CustomerName = responseData['CustomerName'];
            //UserID = responseData['UserID'];

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

  }
}
