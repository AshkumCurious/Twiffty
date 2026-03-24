import 'package:flutter/material.dart';

class BarrierWidget extends StatelessWidget {
  final bool isTop;

  const BarrierWidget({Key? key, required this.isTop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: isTop ? Alignment.topCenter : Alignment.bottomCenter,
          end: isTop ? Alignment.bottomCenter : Alignment.topCenter,
          colors: const [
             Color(0xFF27AE60),
             Color(0xFF1E8449),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: isTop ? const Radius.circular(12) : Radius.zero,
          bottomRight: isTop ? const Radius.circular(12) : Radius.zero,
          topLeft: isTop ? Radius.zero : const Radius.circular(12),
          topRight: isTop ? Radius.zero : const Radius.circular(12),
        ),
        border: Border.all(
          color: const Color(0xFF145A32),
          width: 3,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x441E8449),
            blurRadius: 8,
            offset: Offset(4, 0),
          ),
        ],
      ),
      child: Align(
        alignment: isTop ? Alignment.bottomCenter : Alignment.topCenter,
        child: Container(
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF27AE60),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFF145A32),
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
