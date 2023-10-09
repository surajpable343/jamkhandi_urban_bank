import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRepository {
  Future<dynamic> postApi(var requestParameter, String url) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: requestParameter.toJson(),
          )
          .timeout(const Duration(seconds: 120));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw 'Internal Server Error';
      }
    } catch (e) {
      print("Exception occurred: $e");

      rethrow; // Re-throw the exception to propagate it up the call stack.
    }
  }
}
