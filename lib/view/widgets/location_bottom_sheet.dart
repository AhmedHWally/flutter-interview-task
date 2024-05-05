import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/core/widgets/custom_bottom_sheet_title.dart';
import 'package:optomatica_task/core/widgets/custom_search_textfield.dart';
import 'package:optomatica_task/core/widgets/modal_sheet_button.dart';
import 'package:optomatica_task/model/location_model.dart';
import 'package:optomatica_task/model/race_model.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key, required this.index});
  final int index;
  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  final List<LocationModel> locations = [
    LocationModel(title: 'NEAR MY LOCATION (3)'),
    LocationModel(title: 'Egypt (3)'),
    LocationModel(title: 'Sweden (7)'),
    LocationModel(title: 'Germany (9)'),
    LocationModel(title: 'Greece (4)'),
    LocationModel(title: 'Italy (9)'),
    LocationModel(title: 'Kuwait (2)'),
    LocationModel(title: 'France (3)')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomBottomSheetTitle(
              title: 'RACE LOCATION',
              onPressed: () {
                BlocProvider.of<RacesCubit>(context)
                    .filters[widget.index]
                    .isEnabled = false;

                BlocProvider.of<RacesCubit>(context).reset(index: widget.index);

                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchTextField(
              title: 'Search',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                setState(() {
                  locations[index].isSelected = !locations[index].isSelected;
                  print(locations[index].isSelected);
                });
              },
              child: CustomLocationListile(
                index: index,
                location: locations[index],
              ),
            ),
            itemCount: locations.length,
          )),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                List<String> pickedLocations = [];
                for (var item in locations) {
                  if (item.isSelected == true) {
                    pickedLocations.add(item.title.split(' ')[0]);
                  }
                }
                BlocProvider.of<RacesCubit>(context)
                    .filterByLocation(pickedLocations);
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

class CustomLocationListile extends StatefulWidget {
  const CustomLocationListile(
      {super.key, required this.location, required this.index});
  final LocationModel location;
  final int index;

  @override
  State<CustomLocationListile> createState() => _CustomLocationListileState();
}

class _CustomLocationListileState extends State<CustomLocationListile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.location.title,
            style: widget.index == 0
                ? AppTextStyles.style16w900.copyWith(
                    color: const Color(0xff000A35), fontWeight: FontWeight.w700)
                : AppTextStyles.style16w400
                    .copyWith(color: const Color(0xff000A35)),
          ),
          Checkbox(
            value: widget.location.isSelected,
            onChanged: (value) {
              setState(() {
                widget.location.isSelected = !widget.location.isSelected;
              });
            },
            checkColor: Colors.white,
            activeColor: const Color(0xff1C325F),
            side: const BorderSide(color: Color(0xff1C325F), width: 2),
          )
        ],
      ),
    );
  }
}
