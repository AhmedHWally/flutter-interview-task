import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';

import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';
import 'package:optomatica_task/view/widgets/date_bottom_sheet.dart';
import 'package:optomatica_task/view/widgets/distance_bottom_sheet.dart';
import 'package:optomatica_task/view/widgets/location_bottom_sheet.dart';
import 'package:optomatica_task/view/widgets/reset_bottom_sheet.dart';
import 'package:optomatica_task/view/widgets/type_bottom_sheet.dart';

class FiltersScrollView extends StatelessWidget {
  const FiltersScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RacesCubit, RacesState>(
      builder: (context, state) => Row(
        children: [
          if (BlocProvider.of<RacesCubit>(context).numberOfFilters > 0)
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    context: context,
                    builder: (context) => const ResetBottomSheet());
              },
              child: Container(
                padding: const EdgeInsets.all(13),
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.mainColor),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.filter,
                      color: Colors.white,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: const Color(0xffFFE954),
                      child: Text(
                        '${BlocProvider.of<RacesCubit>(context).numberOfFilters}',
                        style: AppTextStyles.style12w900.copyWith(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          if (BlocProvider.of<RacesCubit>(context).numberOfFilters == 0)
            const SizedBox(
              width: 8,
            ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: BlocProvider.of<RacesCubit>(context)
                      .filters
                      .asMap()
                      .entries
                      .map((filter) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () {
                                switch (filter.value.name) {
                                  case 'Type':
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8))),
                                        context: context,
                                        builder: (context) {
                                          return TypeBottomSheet(
                                            filterIndex: filter.key,
                                          );
                                        });
                                    break;
                                  case 'Location':
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8))),
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: LocationBottomSheet(
                                              index: filter.key,
                                            ),
                                          );
                                        });
                                    break;
                                  case 'Distance':
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8))),
                                        context: context,
                                        builder: (context) {
                                          return DistanceBottomSheet(
                                            index: filter.key,
                                          );
                                        });
                                    break;

                                  case 'Date':
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8))),
                                        context: context,
                                        builder: (context) {
                                          return DateBottomSheet(
                                              index: filter.key);
                                        });
                                    break;
                                }
                              },
                              child: filter.value.isEnabled == true
                                  ? Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          bottom: 8,
                                          right: 8,
                                          top: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.mainColor,
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            filter.value.name,
                                            style: AppTextStyles.style14w500
                                                .copyWith(color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          bottom: 8,
                                          right: 8,
                                          top: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.mainColor)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            filter.value.name,
                                            style: AppTextStyles.style14w500,
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: AppColors.mainColor,
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
