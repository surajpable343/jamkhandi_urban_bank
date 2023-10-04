import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api.dart';
import '../../api_connection/network_utils.dart';
import '../../decoration/background_decoration.dart';
import '../../model/items.dart';
import '../../widgets/footer.dart';
import '../../widgets/header.dart';
import 'AccountRequest.dart';

class RequestScreen extends StatelessWidget {
  final Items item1 = Items(
    title: "Mini Statement",
    img: "assets/images/mini_statement.png",
  );

  final Items item2 = Items(
    title: "Balance Enquiry",
    img: "assets/images/balance_enquiry.png",
  );

  final Items item3 = Items(
    title: "Cheque Book",
    img: "assets/images/cheque_book.png",
  );

  final Items item4 = Items(
    title: "Green Pin",
    img: "assets/images/account_statement.png",
  );

  final Items item5 = Items(
    title: "Loan Calculator",
    img: "assets/images/loan_calc.png",
  );

  @override
  Widget build(BuildContext context) {
    final List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
    ];

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
                const Header(
                  title: 'Request',
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: GridView.count(
                    childAspectRatio: 1.2,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: myList.map((data) {
                      return InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        onTap: () {
                          if (data.title == 'Balance Enquiry') {
                            // Get.to(AccountRequest());
                            _AccountData(context);
                          } else if (data.title == "Cheque Book") {
                            // Get.to(AccountRequest());
                          } else if (data.title == "Mini Statement") {
                            // Get.to(AccountRequest());
                          } else if (data.title == "Green Pin") {
                            // Get.to(AccountRequest());
                          } else if (data.title == "Loan Calculator") {
                            // Get.to(AccountRequest());
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                data.img,
                                width: 42,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 14),
                              Text(
                                data.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const Footer(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
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
      String accountNumber = prefs.getString('AccountNumber') ?? '';
      String rrr = Utils.generateRRR();
      String deviceId = await Utils.getDeviceId();
      String customerId = prefs.getString('CustomerID') ?? '';
      String userID = prefs.getString('UserID') ?? '';

      try {
        var response = await http.post(Uri.parse(API.getKeys), body: {
          "AccountNumber": accountNumber,
          "ReferenceNumber": rrr,
          "DeviceID": deviceId,
          "CustomerID": customerId,
          "UserID": userID,
        });

        print('Request data: $response');

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          responseCode = responseData['ResponseCode'];
          responseDesc = responseData['ResponseDesc'];
          accountNumber = responseData['AccountNumber'];

          print('data: ${response.body}');

          if (responseCode == "00") {
            customerId = responseData['CustomerID'];
            //  CustomerName = responseData['CustomerName'];
            //  UserID = responseData['UserID'];

            print('data: ${response.body}');
          } else {
            Map<String, dynamic> responseData = jsonDecode(response.body);
            String responseDesc = responseData['ResponseDesc'];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  responseDesc,
                  style: TextStyle(color: Colors.white),
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
                style: TextStyle(color: Colors.white),
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
