import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/view/widgets/custom_tab_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.mainColor,
      bottom: const TabBar(
          unselectedLabelStyle: AppTextStyles.style16w900,
          labelStyle: AppTextStyles.style18w900,
          labelPadding: EdgeInsets.symmetric(vertical: 12),
          indicatorColor: Color(0xffFFB715),
          indicatorWeight: 5,
          tabs: [
            CustomTabText(text: 'RUN'),
            CustomTabText(text: 'COMMUNITY'),
            CustomTabText(text: 'RACES')
          ]),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.viewPaddingOf(context).top, bottom: 46),
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/background.png',
                    ),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/images/logo.svg'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                                'assets/images/notification.svg')),
                        IconButton(
                            onPressed: () {},
                            icon:
                                SvgPicture.asset('assets/images/profile.svg')),
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
