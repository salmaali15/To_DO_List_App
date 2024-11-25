import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list_app/logic/task_cubit.dart';

import '../utils/cacheHelper.dart';
import 'AppLayoutScreen.dart';
import 'onBoarding.dart';


class ToDoSplash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDosplash();

}

class _ToDosplash extends State<ToDoSplash> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if(state is initDatabaseSuccess){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => onBoarding(),
            ),
            );
          }
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 41.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Lottie.asset("assets/lottie/todo.json",
                  ),
                ),
                Text("SlalmToDo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}