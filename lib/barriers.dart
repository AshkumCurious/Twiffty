import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {

  final size;

  MyBarrier({this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10.0,color: Colors.green.shade600),
        borderRadius: BorderRadius.circular(15),
      ),

    );
  }
}
