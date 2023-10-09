import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/custom_widget/custom_bottom_bar_small.dart';
import 'package:jamkhandi_urban_bank/screen/payment/WithInBank.dart';

import '../../custom_widget/custom_app_bar.dart';
import '../../decoration/background_decoration.dart';
import '../../model/items.dart';
import '../../widgets/footer.dart';
import '../../widgets/header.dart';

class PaymentScreen extends StatelessWidget {
  Items item1 =
      Items(title: "Within Bank", img: "assets/images/card_control.png");

  Items item2 = Items(
    title: "Other Bank",
    img: "assets/images/payment.png",
  );

  PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
    ];
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Container(
          decoration: BackgroundDecoration.backgroundImage,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Header(
                title: 'Payments',
              ),
              const SizedBox(
                height: 30,
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
                        if (data.title == 'Within Bank') {
                          Get.to(const WithInScreen());
                        } else if (data.title == 'Other Bank') {
                          Get.to(const WithInScreen());
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
      bottomNavigationBar: const CustomBottomBarSmall(),
    );
  }
}
