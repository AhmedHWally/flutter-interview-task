import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optomatica_task/core/utils/bloc_observer.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';
import 'package:optomatica_task/view/home_view.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const OptomaticaTaskApp());
}

class OptomaticaTaskApp extends StatelessWidget {
  const OptomaticaTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RacesCubit()..getRaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: const HomeView(),
      ),
    );
  }
}
