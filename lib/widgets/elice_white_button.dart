import 'package:flutter/material.dart';

class EliceWhiteButton extends StatelessWidget {
  String text;

  EliceWhiteButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(225, 94, 14, 222), // 테두리 색상
          width: 4, // 테두리 두께
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(90),
        ),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 23,
          color: Color.fromARGB(225, 94, 14, 222),
        ),
      )),
    );
  }
}
