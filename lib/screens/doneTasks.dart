import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list_app/logic/task_cubit.dart';

import '../models/taskModel.dart';
import '../widgets/taskWidgets.dart';


class Donetasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Donetasks();
}

class _Donetasks extends State<Donetasks> {
  List<taskModel> taskList = [];

  @override
  void initState(){
    super.initState();
    TaskCubit.get(context).getDoneTaskList();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("To Do List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return state is GetDoneTasksLoading?Center(child: CircularProgressIndicator(),):
          TaskCubit.get(context).doneTasksList.isNotEmpty? ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemBuilder: (context, index) {
              return taskWidgets(
                TaskModel:  TaskCubit.get(context).doneTasksList[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount:  TaskCubit.get(context).doneTasksList.length,
          ) : Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 43
              ),
              child: Lottie.asset("assets/lottie/notfound.json"),
            ),
          );
        },
      ),
    );
  }

}