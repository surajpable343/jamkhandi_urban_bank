import 'package:flutter/material.dart';

class BackgroundDecoration {
  static BoxDecoration get backgroundImage => const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/main_bg.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      );
}
