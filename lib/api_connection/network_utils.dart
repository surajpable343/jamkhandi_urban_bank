import 'dart:io' show InternetAddress, Platform, SocketException;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_info/device_info.dart';

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
}
