import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
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
                  title: 'Payments',
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
                      return Container(
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
    ;
  }
}
