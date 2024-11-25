import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do_list_app/logic/task_cubit.dart';

import '../models/taskModel.dart';
import '../utils/local_database_helper.dart';
import '../widgets/add_task_button_sheet.dart';
import '../widgets/edit_task_button.dart';
import '../widgets/taskWidgets.dart';

class Inprogresstasks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Inprogresstasks();
}

class _Inprogresstasks extends State<Inprogresstasks> {
  List<taskModel> taskList = [];
  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();
  void initDatabase() async {
    await localDatabaseHelper.initDatabase(
        databasePathName: "task_app",
        onCreate: (database, version) async {
          await database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,level TEXT,isDone INTEGER,datetime TEXT)');
        });
    getTaskList();
  }

  void getTaskList() async {
    final List<Map<String, dynamic>> list =
        await localDatabaseHelper.retrieveData(tableName: "tasks");
    print(list);
    list.forEach((element) {
      taskList.add(taskModel.fromMap(element));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    TaskCubit.get(context).getInprogressTaslList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "To Do List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is MakeTaskDoneSuccess)
            TaskCubit.get(context).inProgressTasksList.removeWhere((element) {
              return element.id == state.taskId;
            });
          if(state is RemoveTaskSuccess){
            TaskCubit.get(context).inProgressTasksList.removeWhere((element){
              return element.id == state.removId;
            });
          }
        },
        builder: (context, state) {
          return TaskCubit.get(context).inProgressTasksList.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemBuilder: (context, index) {
                    return taskWidgets(
                      TaskModel:
                          TaskCubit.get(context).inProgressTasksList[index],
                      removePress: () {
                        TaskCubit.get(context).RemoveTask(
                          removId: TaskCubit.get(context)
                                  .inProgressTasksList[index]
                                  .id ??
                              0,
                        );
                      },
                      editPress: () {
                        showModalBottomSheet(context: context,
                            builder: (context){
                               return editButton(
                                 TaskModel: TaskCubit.get(context).inProgressTasksList[index],
                               );
                            },
                        );
                      },
                      donePress: () {
                        TaskCubit.get(context).makeTaskDone(
                            taskId: TaskCubit.get(context)
                                    .inProgressTasksList[index]
                                    .id ??
                                0);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: TaskCubit.get(context).inProgressTasksList.length,
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 43),
                    child: Lottie.asset("assets/lottie/wait.json"),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[700],
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const taskButtonSheet(),
              );
            },
          );
        },
        child: SvgPicture.asset(
          "assets/svg/plus.svg",
          color: Colors.white,
          height: 32,
          width: 32,
        ),
      ),
    );
  }
}
