import 'package:flutter/material.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';

class ModalSheetMainButton extends StatelessWidget {
  const ModalSheetMainButton({
    super.key,
    this.onPressed,
    required this.title,
  });
  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: const Color(0xffFFB715)),
          child: Text(
            title,
            style: AppTextStyles.style14w700,
          )),
    );
  }
}
