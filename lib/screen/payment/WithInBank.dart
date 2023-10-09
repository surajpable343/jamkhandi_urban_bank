import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jamkhandi_urban_bank/colors_model/pick_colors.dart';
import 'package:jamkhandi_urban_bank/custom_widget/custom_app_bar.dart';
import 'package:jamkhandi_urban_bank/screen/payment/ConfirmationPage.dart';

import '../../custom_widget/custom_bottom_bar_small.dart';
import '../../custom_widget/custom_text_widget.dart';
import '../../decoration/background_decoration.dart';
import '../../widgets/header.dart';
import '../startup/otp_verification.dart';
import 'MpinScreen.dart';

class WithInScreen extends StatefulWidget {
  const WithInScreen({Key? key}) : super(key: key);

  @override
  State<WithInScreen> createState() => _WithInScreenState();
}

class _WithInScreenState extends State<WithInScreen> {
  final formKey = GlobalKey<FormState>();
  final accountNoController = TextEditingController();
  final ConfrimAccoController = TextEditingController();
  final beneficaryController = TextEditingController();
  final amountController = TextEditingController();
  final CommantController = TextEditingController();

  @override
  void dispose() {
    accountNoController.dispose();
    ConfrimAccoController.dispose();
    beneficaryController.dispose();
    amountController.dispose();
    CommantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PickColor.lightBlue,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BackgroundDecoration.backgroundImage,
            child:  Column(

              children: [

                const SizedBox(
                  height: 20,
                ),
                const Header(title: 'With IN '),
                Flexible(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: PickColor.lightBlue,
                                  ),
                                  child: CustomTextWidget(
                                    text: 'Beneficiary Account Number',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: accountNoController,
                                  decoration: buildInputDecoration(
                                    Icons.person,
                                    "Enter beneficiary A/c No",
                                  ),
                                  textDirection: TextDirection.ltr,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Account No cannot be empty";
                                    } else if (val.length != 12) {
                                      return "Please enter a 12-digit Account No";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: PickColor.lightBlue,
                                  ),
                                  child: CustomTextWidget(
                                    text: 'Confirm Beneficiary Account Number',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: accountNoController,
                                  decoration: buildInputDecoration(
                                    Icons.person,
                                    "Re-enter beneficiary A/c No.",
                                  ),
                                  textDirection: TextDirection.ltr,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Account No cannot be empty";
                                    } else if (val.length != 12) {
                                      return "Please enter a 12-digit Account No";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: PickColor.lightBlue,
                                  ),
                                  child: CustomTextWidget(
                                    text: 'Beneficiary IFSC',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: accountNoController,
                                  decoration: buildInputDecoration(
                                    Icons.person,
                                    "Enter beneficiary IFSC",
                                  ),
                                  textDirection: TextDirection.ltr,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Account No cannot be empty";
                                    } else if (val.length != 12) {
                                      return "Please enter a 12-digit Account No";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: PickColor.lightBlue,
                                  ),
                                  child: CustomTextWidget(
                                    text: 'Amount',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: accountNoController,
                                  decoration: buildInputDecoration(
                                    Icons.person,
                                    "Enter amount",
                                  ),
                                  textDirection: TextDirection.ltr,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Account No cannot be empty";
                                    } else if (val.length != 12) {
                                      return "Please enter a 12-digit Account No";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: PickColor.lightBlue,
                                  ),
                                  child: CustomTextWidget(
                                    text: 'Comments',
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: accountNoController,
                                  decoration: buildInputDecoration(
                                    Icons.person,
                                    "Enter comment",
                                  ),
                                  textDirection: TextDirection.ltr,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Account No cannot be empty";
                                    } else if (val.length != 12) {
                                      return "Please enter a 12-digit Account No";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),


                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.to(const ConfirmationPagePayment());

                      // if (formKey.currentState!.validate()) {
                      //   }
                    },
                    style: ElevatedButton.styleFrom(

                      backgroundColor: PickColor.blue,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: CustomTextWidget(
                      text: 'Submit',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
      bottomNavigationBar: const CustomBottomBarSmall(),
      );


  }
}
