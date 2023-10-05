import 'dart:io' show InternetAddress, Platform, SocketException;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../colors_model/pick_colors.dart';

class Utils {
  static Future<bool> checkNetworkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[700],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static String generateRRR() {
    String _referenceId = "";
    _referenceId = "${DateTime.now().millisecondsSinceEpoch}";
    return _referenceId;
  }

  static Future<String> getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId = "";
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.androidId; // unique ID on Android devices
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor; // unique ID on iOS devices
    }
    return deviceId;
  }
  static void showProgressDialog(){
    Get.defaultDialog(
      title: "Loading...",
      // middleText: "Hello world!",
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
      backgroundColor: PickColor.white,
      titleStyle: const TextStyle(color: PickColor.blue),
      // middleTextStyle: TextStyle(color: Colors.black),
    );
  }

  static void dismissProgressDialog() {
    if(Get.isDialogOpen?? false){
      Get.back();
    }
    // Get.back(closeOverlays: true);
  }
}
