import 'dart:core';

class API {
  static const hostConnect =
      "https://test.maximusinfoware.in:4436/api/MobileBanking/";
  static const signInUser = "$hostConnect/SIGNUP";
  static const createOtp = "$hostConnect/VERIFYOTP";
  static const createPassword = "$hostConnect/CREATEPASSWORD";
  static const login = "$hostConnect/LOGIN";
  static const changePassword = "$hostConnect/CHANGEPASSWORD";
  static const getKeys = "$hostConnect/GetKeys";
  static const checkForUpdate = "$hostConnect/CheckForUpdate";
  static const signUP = "$hostConnect/SIGNUP";

  static const changemPin = "$hostConnect/CHANGEMPIN";
  static const forgetTpin = "$hostConnect/ForgetTpin";
  static const createOTP = "$hostConnect/CreateOTP";

  static String  get getKeysData => "$hostConnect/GetKeys";

}
