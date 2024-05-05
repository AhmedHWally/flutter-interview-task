import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/core/widgets/modal_sheet_button.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';

class ResetBottomSheet extends StatelessWidget {
  const ResetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Clear filters?',
                style: AppTextStyles.style22w700,
              ),
            ),
            ModalSheetMainButton(
              title: 'YES, CLEAR FILTERS',
              onPressed: () {
                BlocProvider.of<RacesCubit>(context).reset();
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: const BorderSide(color: AppColors.mainColor),
                      elevation: 0,
                      backgroundColor: const Color(0xffFFFFFF)),
                  child: const Text(
                    'CANCEL',
                    style: AppTextStyles.style14w700,
                  )),
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
