import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/screen/payment/payment.dart';
import 'package:jamkhandi_urban_bank/screen/requests/request_screen.dart';
import 'package:jamkhandi_urban_bank/screen/setting/setting_screen.dart';
import 'package:jamkhandi_urban_bank/widgets/footer.dart';
import '../../decoration/background_decoration.dart';
import '../../model/items.dart';
import '../../widgets/header.dart';

class MainScreen extends StatelessWidget {
  Items item1 =
      Items(title: "Card Control", img: "assets/images/card_control.png");

  Items item2 = Items(
    title: "Payment",
    img: "assets/images/payment.png",
  );
  Items item3 = Items(
    title: "Requests",
    img: "assets/images/requests.png",
  );
  Items item4 = Items(
    title: "Setting",
    img: "assets/images/settings.png",
  );
  Items item5 = Items(
    title: "My Account",
    img: "assets/images/accounts.png",
  );
  Items item6 = Items(
    title: "Manage Beneficiary",
    img: "assets/images/wallet.png",
  );
  Items item7 = Items(
    title: "My Account",
    img: "assets/images/splash.jpg",
  );
  Items item8 = Items(
    title: "Manage Beneficiary",
    img: "assets/images/splash.jpg",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
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
                  title: 'WELCOME',
                ),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: GridView.count(
                    childAspectRatio: 1.2,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: myList.map((data) {
                      return InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        onTap: () {
                          if (data.title == 'Payment') {
                            Get.to(PaymentScreen());
                          } else if (data.title == 'Requests') {
                            Get.to(RequestScreen());
                          } else if (data.title == 'Setting') {
                            Get.to(const SettingScreen());
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
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                data.img,
                                width: 42,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 14),
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
}
