import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/core/widgets/custom_bottom_sheet_title.dart';
import 'package:optomatica_task/core/widgets/modal_sheet_button.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';

class DateBottomSheet extends StatefulWidget {
  const DateBottomSheet({super.key, required this.index});
  final int index;
  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  DateTime initalDate = DateTime.now();
  DateTime finalDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomBottomSheetTitle(
              title: 'RACE DATE',
              onPressed: () {
                if (BlocProvider.of<RacesCubit>(context)
                        .filters[widget.index]
                        .isEnabled ==
                    true) {
                  BlocProvider.of<RacesCubit>(context)
                      .filters[widget.index]
                      .isEnabled = false;
                  BlocProvider.of<RacesCubit>(context)
                      .reset(index: widget.index);
                }

                Navigator.of(context).pop();
              },
            ),
          ),
          CustomDateButton(
            date: initalDate,
            title: 'From',
            onTap: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                  initialDate: DateTime.now());
              if (picked != null) {
                setState(() {
                  initalDate = picked;
                });
              }
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomDateButton(
            date: finalDate,
            title: 'To',
            onTap: () async {
              DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now());
              if (picked != null) {
                setState(() {
                  finalDate = picked;
                });
              }
            },
          ),
          const SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
            child: ModalSheetMainButton(
              title: 'DONE',
              onPressed: () {
                if (BlocProvider.of<RacesCubit>(context)
                        .filters[widget.index]
                        .isEnabled ==
                    false) {
                  BlocProvider.of<RacesCubit>(context)
                      .filters[widget.index]
                      .isEnabled = true;
                  BlocProvider.of<RacesCubit>(context).numberOfFilters += 1;
                }
                BlocProvider.of<RacesCubit>(context)
                    .filterByDate(initalDate, finalDate);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

class CustomDateButton extends StatelessWidget {
  const CustomDateButton(
      {super.key, required this.date, required this.title, this.onTap});
  final DateTime date;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style:
                AppTextStyles.style14w500.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 6,
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondaryColor)),
              child: ListTile(
                minLeadingWidth: 0,
                leading: const Icon(
                  FontAwesomeIcons.calendarDays,
                  color: AppColors.mainColor,
                  size: 20,
                ),
                title: Text(
                  DateFormat.yMMMMEEEEd().format(date),
                  style: AppTextStyles.style16w400
                      .copyWith(color: const Color(0xff1C325F)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
