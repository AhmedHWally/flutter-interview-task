import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/widgets/custom_search_textfield.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';
import 'package:optomatica_task/view/widgets/custom_race_container.dart';
import 'package:optomatica_task/view/widgets/filters_scroll_view.dart';

class RacesViewBody extends StatefulWidget {
  const RacesViewBody({super.key});

  @override
  State<RacesViewBody> createState() => _RacesViewBodyState();
}

class _RacesViewBodyState extends State<RacesViewBody>
    with AutomaticKeepAliveClientMixin<RacesViewBody> {
  bool isLoading = false;

  @override
  void dispose() {
    BlocProvider.of<RacesCubit>(context).scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<RacesCubit, RacesState>(listener: (context, state) {
      if (state is RacesDataSuccess) {
        print('done');
      }
    }, builder: (context, state) {
      if (state is RacesDataFailed) {
        return const Center(
          child: Text('error happend'),
        );
      } else if (state is RacesDataSuccess) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (!isLoading &&
                scrollNotification is ScrollUpdateNotification &&
                scrollNotification.metrics.extentAfter <=
                    MediaQuery.of(context).size.height * 0.05 &&
                scrollNotification.metrics.axis == Axis.vertical &&
                BlocProvider.of<RacesCubit>(context).items.length !=
                    BlocProvider.of<RacesCubit>(context).showedItems.length &&
                BlocProvider.of<RacesCubit>(context).isCurrentlyFiltring !=
                    true) {
              setState(() {
                isLoading = true;
              });
              Future.delayed(const Duration(seconds: 1)).then((value) {
                BlocProvider.of<RacesCubit>(context).pagination();
                BlocProvider.of<RacesCubit>(context).numberOfItems += 5;
                setState(() {
                  isLoading = false;
                });
              });
            }
            return false;
          },
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverPadding(
                padding:
                    EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
                sliver: SliverToBoxAdapter(
                  child: CustomSearchTextField(
                      title: 'Search Race Name or Country'),
                ),
              ),
              const SliverToBoxAdapter(
                child: FiltersScrollView(),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                sliver: SliverList.builder(
                  itemBuilder: (context, index) => CustomRaceContainer(
                      race: BlocProvider.of<RacesCubit>(context)
                          .showedItems[index]),
                  itemCount:
                      BlocProvider.of<RacesCubit>(context).showedItems.length,
                ),
              ),
              if (isLoading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.sizeOf(context).height * 0.05),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                )
            ],
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
