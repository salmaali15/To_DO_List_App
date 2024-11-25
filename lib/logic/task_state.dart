part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class GetTasksLoading extends TaskState {}

final class GetTasksSuccess extends TaskState {}

final class GetTasksError extends TaskState {}

final class GetDoneTasksSuccess extends TaskState {}

final class GetDoneTasksLoading extends TaskState {}
final class GetInprogTasksLoading extends TaskState {}

final class GetInprogTasksSuccess extends TaskState {}

final class GetDoneTasksError extends TaskState {}


final class GetInprogTasksError extends TaskState {}

final class initDatabaseLoading extends TaskState {}

final class initDatabaseSuccess extends TaskState {}

final class initDatabaseError extends TaskState {}

final class MakeTaskDoneLoading extends TaskState {}

final class MakeTaskDoneSuccess extends TaskState {
  final int taskId;

  MakeTaskDoneSuccess({required this.taskId});
}

final class MakeTaskDoneError extends TaskState {}

final class AddNewTaskLoading extends TaskState {}
final class AddNewTaskSuccess extends TaskState {}
final class AddNewTaskError extends TaskState {}

final class RemoveTaskLoading extends TaskState {}

final class RemoveTaskSuccess extends TaskState {
  final int removId;

  RemoveTaskSuccess({required this.removId});
}

final class RemoveTaskError extends TaskState {}

final class EditTaskLoading extends TaskState {}

final class EditTaskSuccess extends TaskState {}

final class EditTaskError extends TaskState {}
