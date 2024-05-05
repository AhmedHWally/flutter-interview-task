part of 'races_cubit.dart';

abstract class RacesState {}

final class RacesInitial extends RacesState {}

final class RacesDataLoading extends RacesState {}

final class RacesDataSuccess extends RacesState {}

final class RacesDataFailed extends RacesState {}

final class RacesDataFiltering extends RacesState {}
