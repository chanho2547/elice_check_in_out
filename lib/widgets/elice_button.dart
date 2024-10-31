import 'package:flutter/material.dart';

class EliceButton extends StatelessWidget {
  String text;
  EliceButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: const BoxDecoration(
        color: Color.fromARGB(225, 94, 14, 222),
        borderRadius: BorderRadius.all(
          Radius.circular(90),
        ),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 23,
          color: Colors.white,
        ),
      )),
    );
  }
}
