import 'package:flutter/material.dart';
import 'globalvar.dart';

class MyBird extends StatelessWidget {
  const MyBird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(avr[avatar-1],
          height: 60.0,
          width: 60.0,
        );
  }
}
