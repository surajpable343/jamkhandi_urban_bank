import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/colors_model/pick_colors.dart';
import 'package:jamkhandi_urban_bank/custom_widget/custom_text_widget.dart';

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
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: PickColor.blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 32,),
            onPressed: () {
              Get.back();
            },
            color: Colors.white,
            alignment: Alignment.center,
            // padding: const EdgeInsets.only(bottom: 2),
          ),

          CustomTextWidget(
            text: title.toUpperCase(),
            textAlign: TextAlign.center,
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
              width: 26.0
          ),
        ],
      ),
    );
  }
}
