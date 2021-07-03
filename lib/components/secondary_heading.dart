import 'package:flutter/material.dart';

class SecondaryHeading extends StatelessWidget {
  String text;
  SecondaryHeading({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
        color: Colors.blueAccent,
      ),
    );
  }
}
