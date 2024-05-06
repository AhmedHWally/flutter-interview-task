import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_task/model/filter_item_model.dart';
import 'package:optomatica_task/model/race_model.dart';
part 'races_state.dart';

class RacesCubit extends Cubit<RacesState> {
  RacesCubit() : super(RacesInitial());

  List<RaceModel> items = [];
  List<RaceModel> showedItems = [];
  final List<FilterItemModel> filters = [
    FilterItemModel(name: 'Type'),
    FilterItemModel(name: 'Location'),
    FilterItemModel(name: 'Distance'),
    FilterItemModel(name: 'Date'),
  ];
  int index = 0;
  int numberOfItems = 10;
  bool isCurrentlyFiltring = false;
  final ScrollController scrollController = ScrollController();

  int numberOfFilters = 0;

  Future<void> getRaces() async {
    emit(RacesDataLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final String response =
          await rootBundle.loadString('assets/races_data.json');
      final data = await json.decode(response);
      items = (data as List<dynamic>)
          .map((json) => RaceModel.fromJson(json))
          .toList();
      while (index < 5 &&
          showedItems.length != items.length &&
          index < numberOfItems) {
        showedItems.add(items[index]);
        index++;
      }
      emit(RacesDataSuccess());
    } catch (e) {
      emit(RacesDataFailed());
    }
  }

  void pagination() {
    while (index < items.length &&
        showedItems.length != items.length &&
        index < numberOfItems &&
        isCurrentlyFiltring != true) {
      showedItems.add(items[index]);
      index++;
    }
    emit(RacesDataSuccess());
  }

  void searchItems(String value) {
    showedItems = items
        .where((element) =>
            element.name.contains(value.trim()) ||
            element.city.contains(value.trim()) ||
            element.country.contains(value.trim()))
        .toList();
    isCurrentlyFiltring = true;
    emit(RacesDataSuccess());
  }

  void filterItemsByDistance(double value1, double value2) {
    List<RaceModel> tempItems = [];
    bool itemIsVlid = false;
    for (var item in items) {
      List<String> parts = item.distances.split(',');
      List<double> numbers = parts.map((part) {
        String numericString =
            part.split('K')[0]; // Extract numeric part before 'K'
        return double.parse(numericString);
      }).toList();
      for (var number in numbers) {
        if (number >= value1 && number <= value2) {
          itemIsVlid = true;
        } else {
          itemIsVlid = false;
        }
      }
      if (itemIsVlid) {
        tempItems.add(item);
      }
    }
    showedItems = tempItems;
    isCurrentlyFiltring = true;
    emit(RacesDataSuccess());
  }

  void filterByType(String type) {
    if (type == 'Real-time event') {
      showedItems =
          items.where((element) => element.type == 'Real-time').toList();
    } else if (type == 'Virtual') {
      showedItems =
          items.where((element) => element.type == 'Virtual').toList();
    } else {
      showedItems = items;
      numberOfFilters -= 1;
      filters[0].isEnabled = false;
    }
    isCurrentlyFiltring = true;
    emit(RacesDataSuccess());
  }

  void filterByDate(DateTime initalDate, DateTime finalDate) {
    List<RaceModel> temporaryList = [];
    for (int index = 0; index < items.length; index++) {
      final DateTime raceDate = DateTime.parse(items[index].date);
      if (raceDate.isBefore(finalDate) && raceDate.isAfter(initalDate)) {
        temporaryList.add(items[index]);
      }
    }
    showedItems = temporaryList;
    isCurrentlyFiltring = true;
    emit(RacesDataSuccess());
  }

  void filterByLocation(List<String> locations) {
    List<RaceModel> tempItems = [];
    for (var item in locations) {
      tempItems.addAll([...items.where((element) => element.country == item)]);
    }
    showedItems = tempItems;
    isCurrentlyFiltring = true;
    emit(RacesDataSuccess());
  }

  void reset({int? index}) {
    if (index == null) {
      showedItems = items;
      for (int index = 0; index < filters.length; index++) {
        filters[index].isEnabled = false;
      }

      numberOfFilters = 0;
      isCurrentlyFiltring = true;
      emit(RacesDataSuccess());
    } else {
      filters[index].isEnabled = false;
      numberOfFilters -= 1;
      showedItems = items;
      emit(RacesDataSuccess());
    }
  }
}
