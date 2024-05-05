import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/core/widgets/modal_sheet_button.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';

class TypeBottomSheet extends StatefulWidget {
  const TypeBottomSheet({super.key, required this.filterIndex});
  final int filterIndex;
  @override
  State<TypeBottomSheet> createState() => _TypeBottomSheetState();
}

class _TypeBottomSheetState extends State<TypeBottomSheet> {
  int pickedIndex = 0;
  static const List<String> types = ['Real-time event', 'Virtual', 'All'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 16),
            child: Text(
              'RACE TYPE',
              style: AppTextStyles.style22w700,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.mainColor,
            ),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  pickedIndex = index;
                });
              },
              child: CustomTypeListTile(
                isSelected: pickedIndex == index,
                type: types[index],
              ),
            ),
            itemCount: 3,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
            child: ModalSheetMainButton(
              title: 'DONE',
              onPressed: () {
                if (BlocProvider.of<RacesCubit>(context)
                        .filters[widget.filterIndex]
                        .isEnabled ==
                    false) {
                  BlocProvider.of<RacesCubit>(context)
                      .filters[widget.filterIndex]
                      .isEnabled = true;
                  BlocProvider.of<RacesCubit>(context).numberOfFilters += 1;
                }
                BlocProvider.of<RacesCubit>(context)
                    .filterByType(types[pickedIndex]);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

class CustomTypeListTile extends StatelessWidget {
  const CustomTypeListTile(
      {super.key, this.isSelected = false, required this.type});
  final bool isSelected;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, right: 24, left: 24),
      child: Row(
        children: [
          Text(
            type,
            style: AppTextStyles.style16w400
                .copyWith(color: const Color(0xff000A35)),
          ),
          const Spacer(),
          Container(
            width: 18,
            height: 18,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppColors.mainColor, width: 2)),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.mainColor : Colors.white),
              width: double.infinity,
              height: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
