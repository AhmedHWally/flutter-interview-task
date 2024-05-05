import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/model/race_model.dart';
import 'package:optomatica_task/view/widgets/custom_race_container_data_row.dart';

class CustomRaceContainer extends StatelessWidget {
  const CustomRaceContainer({super.key, required this.race});
  final RaceModel race;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          print('tapped');
        },
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 8,
            color: const Color(0xffF1F4FD),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, top: 8, bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.mainColor,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Icon(
                                  Icons.star_rate_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              race.name,
                              maxLines: 2,
                              style: AppTextStyles.style16w900
                                  .copyWith(color: AppColors.mainColor),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text('Orgaized by',
                                style: AppTextStyles.style14w500
                                    .copyWith(color: const Color(0xff8E9BC3))),
                            const SizedBox(
                              height: 4,
                            ),
                            if (race.organizer != '')
                              Text(
                                race.organizer,
                                style: AppTextStyles.style14w500
                                    .copyWith(color: const Color(0xffBD5000)),
                              ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      CustomRaceContainerDataRow(
                                        text: race.distances,
                                        icon: FontAwesomeIcons.route,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      CustomRaceContainerDataRow(
                                        text:
                                            "${race.date.substring(0, 4)}/${race.date.substring(4, 6).toString().padLeft(2, '0')}/${race.date.substring(6)}",
                                        icon: FontAwesomeIcons.calendarDays,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      CustomRaceContainerDataRow(
                                        text: '${race.city}, ${race.country}',
                                        icon: FontAwesomeIcons.locationDot,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: InkWell(
                                  child: SvgPicture.asset(
                                      'assets/images/shareIcon.svg'),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: Image.asset(
                      'assets/images/${race.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
