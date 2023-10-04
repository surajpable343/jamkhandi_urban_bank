import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30,
            child: Icon(
              Icons.question_mark,
              size: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30,
            child: Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 30,
            child: Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
