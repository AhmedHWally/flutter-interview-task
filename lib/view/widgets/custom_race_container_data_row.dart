import 'package:flutter/material.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';

class CustomRaceContainerDataRow extends StatelessWidget {
  const CustomRaceContainerDataRow({super.key, this.icon, required this.text});
  final IconData? icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: const Color(0xff4B5B8D),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.style12w900,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
