import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
