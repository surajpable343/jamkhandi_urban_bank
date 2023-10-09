import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamkhandi_urban_bank/api_connection/API.dart';
import 'package:jamkhandi_urban_bank/api_connection/network_utils.dart';

import 'package:http/http.dart' as http;
import 'package:jamkhandi_urban_bank/screen/dashboard/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/progresbar.dart';
import 'Registration_SplashDemo.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after 5 seconds
    _startTimer();
  }

  void _startTimer() {
    // Simulate a time-consuming operation
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
      // Navigate to Sign In screen
      Get.to(_GetKeys());
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget container = Center(
        // Your existing UI code here
        );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpg'),
                  fit: BoxFit.cover),
            ),
            child: container,
          ),
          if (_isLoading) ProgressBar(),
        ],
      ),
    );
  }

  Future<void> _GetKeys() async {
    bool isConnected = await Utils.checkNetworkConnectivity();
    if (isConnected) {
      String responseCode;
      String rrr = Utils.generateRRR();
      String deviceId = await Utils.getDeviceId();
      try {
        var response = await http.post(Uri.parse(API.getKeys), body: {

        });
        print('Request data: ${response}');
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];
          String responseDesc = responseData['ResponseDesc'];
          String EncerytedKey = responseData['EncryptionKey'];

          print('data: ${response.body}');
          if (responseCode == "00") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('EncryptionKey', EncerytedKey);
            _CheckforUpdate();
          } else {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            String responseDesc = responseData['ResponseDesc'];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  responseDesc,
                  style: const TextStyle(color: Colors.white), // Set the text color
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please check Internet Connection",
            style: TextStyle(color: Colors.white), // Set the text color
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _CheckforUpdate() async {
    bool isConnected = await Utils.checkNetworkConnectivity();
    if (isConnected) {
      String responseCode;
      String rrr = Utils.generateRRR();
      String deviceId = await Utils.getDeviceId();
      try {
        var response = await http.post(Uri.parse(API.checkForUpdate), body: {

        });
        print('Request data: ${response}');
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];
          String responseDesc = responseData['ResponseDesc'];
          List<dynamic> checkUpdateArray = responseData['CheckUpdate'];
          // Check if the array is not empty and has at least one element
          if (checkUpdateArray.isNotEmpty) {
            // Access the first element in the array
            Map<String, dynamic> firstElement = checkUpdateArray[0];

            // Extract properties from the first element
            String iosVersion = firstElement['IOSVERSION'];
            int iosUpdateType = firstElement['IOSUPDATETYPE'];
            String androidVersion = firstElement['ANDROIDVERSION'];
            int androidUpdateType = firstElement['ANDROIDUPDATETYPE'];


          } else {
            print('CheckUpdate array is empty or missing');
          }

          print('data: ${response.body}');
          if (responseCode == "00") {
            Get.to(MainScreen());
          } else {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            String responseDesc = responseData['ResponseDesc'];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  responseDesc,
                  style: const TextStyle(color: Colors.white), // Set the text color
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please check Internet Connection",
            style: TextStyle(color: Colors.white), // Set the text color
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
