import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_widget/custom_app_bar.dart';
import '../../custom_widget/custom_bottom_bar_small.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/header.dart';
import '../startup/otp_verification.dart';

class Mpin_Confiramtion extends StatelessWidget {
  const Mpin_Confiramtion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BackgroundDecoration.backgroundImage,
            ),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(
                parent: NeverScrollableScrollPhysics(),
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Header(title: 'M-Pin Confirmation'),
                  Form(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40.0),
                          Container(
                            width: double.infinity,
                            height: 40,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            padding: EdgeInsets.all(5.0),
                            color: Colors.blue,
                            child: const Text(
                              'Acknowledgement',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            padding: EdgeInsets.all(5.0),
                            color: Colors.white,
                            child: const Text(
                              'NA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomBarSmall(),
    );
  }
}
