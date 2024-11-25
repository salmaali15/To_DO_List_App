import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list_app/logic/task_cubit.dart';
import 'package:to_do_list_app/screens/AppLayoutScreen.dart';
import 'package:to_do_list_app/screens/splash_screen.dart';

import 'bloc_observer.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TaskCubit()..initDatabase()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ToDoSplash(),
        ),
    );
  }
}


