import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamkhandi_urban_bank/screen/startup/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jamkhandi urban bank',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        builder: (context, dataSnapShot) => SplashScreen(),
      ),
    );
  }
}