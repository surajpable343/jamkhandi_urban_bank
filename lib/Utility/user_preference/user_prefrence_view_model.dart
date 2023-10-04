
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';




class SharedPrefClass {
  final SharedPreferences sharedPreferences;


  SharedPrefClass({required this.sharedPreferences});

  void clearPreference() {
    sharedPreferences.clear();
  }

  void clearSpecificKeyPreference(String keyName) {
    sharedPreferences.remove(keyName);
  }

  void saveData<T>(String key, Type dataType, T? data) {
    if (dataType == String) {
      sharedPreferences.setString(key, data.toString());
    } else if (dataType == int) {
      sharedPreferences.setInt(key, int.parse(data.toString()));
    } else if (dataType == bool) {
      sharedPreferences.setBool(key, data.toString().toLowerCase() == 'true');
    } else if (dataType == double) {
      sharedPreferences.setDouble(key, double.parse(data.toString()));
    }
  }

  T getUserData<T>(String key, Type dataType, T defaultValue) {
    var data;
    if (dataType == String) {
      data = sharedPreferences.getString(key) ?? defaultValue.toString();
    } else if (dataType == int) {
      data =
          sharedPreferences.getInt(key) ?? int.parse(defaultValue.toString());
    } else if (dataType == bool) {
      data = sharedPreferences.getBool(key) ?? defaultValue;
    } else if (dataType == double) {
      data = sharedPreferences.getDouble(key) ??
          double.parse(defaultValue.toString());
    }
    return data as T;
  }

  // void saveCustomerList(List<CustomerDetails> customerList) {
  //   final encodedList = customerList.map((customer) => customer.toJson()).toList();
  //   final jsonString = json.encode(encodedList);
  //   sharedPreferences.setString('customerListKey', jsonString);
  // }
  //
  // List<CustomerDetails> getCustomerList() {
  //
  //   final jsonString = sharedPreferences.getString('customerListKey');
  //   if (jsonString != null) {
  //     final decodedList = json.decode(jsonString) as List<dynamic>;
  //     final customerList = decodedList.map((json) => CustomerDetails.fromJson(json)).toList();
  //     return customerList;
  //   } else {
  //     return [];
  //   }
  // }



}
