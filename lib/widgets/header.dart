import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/colors_model/pick_colors.dart';

class Header extends StatelessWidget {
  const Header({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      width: double.infinity,
      height: 45,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: PickColor.blue,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
              color: Colors.white,

             // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 8),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Text(
            title.toUpperCase(),

            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
