import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';

import 'package:optomatica_task/view/widgets/custom_appbar.dart';
import 'package:optomatica_task/view/widgets/races_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2,
      child: Scaffold(
        body: NestedScrollView(
            controller: BlocProvider.of<RacesCubit>(context).scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  const CustomAppBar(),
                ],
            body: const TabBarView(
              children: [
                Center(
                  child: Text(""),
                ),
                Center(
                  child: Text(""),
                ),
                RacesViewBody()
              ],
            )),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.white),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedLabelStyle:
                AppTextStyles.style12w900.copyWith(fontWeight: FontWeight.w500),
            unselectedLabelStyle:
                AppTextStyles.style12w900.copyWith(fontWeight: FontWeight.w500),
            items: [
              const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      FontAwesomeIcons.house,
                      size: 20,
                    ),
                  ),
                  label: 'Home'),
              const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      FontAwesomeIcons.bullseye,
                      size: 20,
                    ),
                  ),
                  label: 'TRAIN'),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xffFFB715),
                    child: Center(
                      child: Image.asset('assets/images/Icon.png'),
                    ),
                  ),
                  label: ''),
              const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      FontAwesomeIcons.magnifyingGlassLocation,
                      size: 20,
                    ),
                  ),
                  label: 'EXPLORE'),
              const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      FontAwesomeIcons.chartLine,
                      size: 20,
                    ),
                  ),
                  label: 'ME')
            ],
            currentIndex: 2,
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
