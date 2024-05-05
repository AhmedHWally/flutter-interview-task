import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/core/widgets/custom_bottom_sheet_title.dart';
import 'package:optomatica_task/core/widgets/modal_sheet_button.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';

class DistanceBottomSheet extends StatefulWidget {
  const DistanceBottomSheet({super.key, required this.index});
  final int index;
  @override
  State<DistanceBottomSheet> createState() => _DistanceBottomSheetState();
}

class _DistanceBottomSheetState extends State<DistanceBottomSheet> {
  RangeValues values = const RangeValues(0, 200);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CustomBottomSheetTitle(
              title: 'Distance',
              onPressed: () {
                BlocProvider.of<RacesCubit>(context)
                    .filters[widget.index]
                    .isEnabled = false;
                print(widget.index);
                BlocProvider.of<RacesCubit>(context).reset(index: widget.index);

                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                '${values.start.round()}K - ${values.end.round()}K',
                style: AppTextStyles.style16w400
                    .copyWith(color: const Color(0xff1C325F)),
              )),
          Padding(
            padding: const EdgeInsets.all(24),
            child: RangeSlider(
                values: values,
                min: 0,
                max: 200,
                activeColor: const Color(0xffFFB715),
                onChanged: (value) {
                  setState(() {
                    values = value;
                  });
                }),
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
                    .filterItemsByDistance(values.start, values.end);

                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
