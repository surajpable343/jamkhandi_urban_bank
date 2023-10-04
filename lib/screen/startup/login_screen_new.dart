import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../decoration/background_decoration.dart';

class login_Screen_new extends StatefulWidget {
  const login_Screen_new({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    bool _isLoading = false;
    return  Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BackgroundDecoration.backgroundImage,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),

                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.blue,
                                ),
                                child: const Text(
                                  'Account No',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              TextFormField(

                                maxLength: 12,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                  hintText: "Enter Account No",
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                validator: (val) => val == ""
                                    ? "Account number cannot be empty"
                                    : val?.length != 12
                                    ? "Please enter valid Account number"
                                    : null,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      signInUSer();
                                    }
                                  },
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                      : const Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white),
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
              ),
            ),
          ]),
        ),
      ),

    );
  }

  void signInUSer() {}
}
