import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/colors_model/pick_colors.dart';
import 'package:jamkhandi_urban_bank/screen/startup/sign_up_screen.dart';
import 'package:jamkhandi_urban_bank/screen/startup/signin_screen.dart';

import '../../widgets/progresbar.dart';

class Registration_SplashDemo extends StatefulWidget {
  @override
  State<Registration_SplashDemo> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Registration_SplashDemo> {
  bool _isLoading = false;

  void _handleClick() {
    setState(() {
      _isLoading = true;
    });

    // Simulate a time-consuming operation
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget container = Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(SignInScreen());
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: PickColor.blue),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to( SignUpScreen());
                      // _handleClick();
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: PickColor.blue),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpg'),
                  fit: BoxFit.cover),
            ),
            child: container,
          ),
          if (_isLoading) const ProgressBar(),
        ],
      ),
    );
  }
}
