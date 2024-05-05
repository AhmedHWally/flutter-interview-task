import 'package:flutter/material.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';

class CustomBottomSheetTitle extends StatelessWidget {
  const CustomBottomSheetTitle(
      {super.key, this.onPressed, required this.title});
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const TextButton(
            onPressed: null,
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.white),
            )),
        Text(
          title,
          style: AppTextStyles.style22w700,
        ),
        TextButton(
            onPressed: onPressed,
            child: const Text(
              'Reset',
              style: TextStyle(color: Color(0xffBD5000)),
            ))
      ],
    );
  }
}
