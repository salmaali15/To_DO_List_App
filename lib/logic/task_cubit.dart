import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../models/taskModel.dart';
import '../utils/local_database_helper.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  static TaskCubit get(context) {
    return BlocProvider.of(context);
  }

  List<taskModel> taskList = [];
  List<taskModel> doneTasksList = [];
  List<taskModel> inProgressTasksList = [];

  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper();

  void initDatabase() async {
    emit(initDatabaseLoading());
    try {
      await localDatabaseHelper.initDatabase(
          databasePathName: "task_app",
          onCreate: (database, version) async {
            await database.execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,level TEXT,isDone INTEGER,datetime TEXT)');
          });
      emit(initDatabaseSuccess());
    } catch (error) {
      emit(initDatabaseError());
    }
  }

  Future<void> getDoneTaskList() async {
    doneTasksList.clear();
    emit(GetDoneTasksLoading());
    try {
      final List<Map<String, dynamic>> list = await localDatabaseHelper
          .retrieveData(tableName: "tasks", where: "isDone = 1");
      for (var i in list) {
        doneTasksList.add(taskModel.fromMap(i));
      }
      emit(GetDoneTasksSuccess());
    } catch (error) {
      emit(GetDoneTasksError());
    }
  }

  Future<void> getInprogressTaslList() async {
    inProgressTasksList.clear();
    emit(GetInprogTasksLoading());
    try {
      final List<Map<String, dynamic>> list = await localDatabaseHelper
          .retrieveData(tableName: "tasks", where: "isDone = 0");
      for (var i in list) {
        inProgressTasksList.add(taskModel.fromMap(i));
      }
      emit(GetInprogTasksSuccess());
    } catch (error) {
      emit(GetInprogTasksError());
    }
  }

  Future<void> makeTaskDone({required int taskId}) async {
    emit(MakeTaskDoneLoading());
    try {
      await localDatabaseHelper.updateDatabase(values: {
        "isDone": 1,
      }, tableName: "tasks", query: "id = $taskId");
      final List<Map<String, dynamic>> list = await localDatabaseHelper
          .retrieveData(tableName: "tasks", where: "isDone = 1");
      for (var e in list) {
        doneTasksList.add(taskModel.fromMap(e));
      }
      emit(MakeTaskDoneSuccess(taskId: taskId));
    } catch (error) {
      emit(MakeTaskDoneError());
    }
  }

  void addNewTask({required taskModel taskModel}) async {
    emit(AddNewTaskLoading());
    try {
      await localDatabaseHelper.insertToDatabase(
          values: taskModel.toMap(), tableName: "tasks");
      emit(AddNewTaskSuccess());
    } catch (error) {
      emit(AddNewTaskError());
    }
  }

  Future<void> RemoveTask({required int removId}) async {
    emit(RemoveTaskLoading());
    try {
      await localDatabaseHelper.deleteDatabase(
          tableName: "tasks", query: "id = $removId");
      emit(RemoveTaskSuccess(removId: removId));
    } catch (error) {
      emit(RemoveTaskError());
    }
  }

  Future<void> editTask({required taskModel taskModel}) async {
    emit(EditTaskLoading());
    try {
      await localDatabaseHelper.updateDatabase(
          values: taskModel.toMap(),
          tableName: "tasks",
          query: "id = ${taskModel.id}");
      emit(EditTaskSuccess());
    } catch (error) {
      emit(EditTaskError());
    }
  }
}
