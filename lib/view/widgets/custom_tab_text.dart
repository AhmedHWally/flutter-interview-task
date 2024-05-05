import 'package:flutter/material.dart';

class CustomTabText extends StatelessWidget {
  const CustomTabText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
      ),
    );
  }
}
