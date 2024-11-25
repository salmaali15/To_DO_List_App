import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../logic/task_cubit.dart';
import '../models/taskModel.dart';
import '../utils/enums/taskLevels.dart';
import '../utils/local_database_helper.dart';

class editButton extends StatefulWidget {

  final taskModel TaskModel;
  const editButton({super.key, required this.TaskModel});


  @override
  State<StatefulWidget> createState() => _editButton();
}

class _editButton extends State<editButton> {

  void intResourses(){
    controller = TextEditingController(text: widget.TaskModel.title);
    value = levels.firstWhere((element){
      return element.name == widget.TaskModel.level;
    });
    datetime = widget.TaskModel.datetime;
  }

  List<taskLevelsEnums> levels = [
    taskLevelsEnums.High,
    taskLevelsEnums.Medium,
    taskLevelsEnums.Low
  ];
  taskLevelsEnums? value;
  String? datetime;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    intResourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is EditTaskSuccess) {
          Navigator.pop(context);
          TaskCubit.get(context).getInprogressTaslList();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Task Title",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  hint: Text("Task level"),
                  decoration: InputDecoration(
                    hintText: "level",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  items: levels
                      .map(
                        (level) => DropdownMenuItem(
                      child: Text(level.name),
                      value: level,
                    ),
                  )
                      .toList(),
                  value: value,
                  onChanged: (level) {
                    setState(() {
                      value = level;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 365),
                      ),
                    ).then((date) {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((time) {
                        datetime = date
                            ?.add(
                          Duration(
                            hours: time?.hour ?? 0,
                            minutes: time?.minute ?? 0,
                          ),
                        )
                            .toString();
                        setState(() {});
                      });
                    }).catchError((error) {});
                  },
                  child: Text(
                    datetime != null
                        ? Jiffy.parse(datetime ?? "").yMMMMEEEEdjm
                        : "Select Date & Time",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      TaskCubit.get(context).editTask(
                        taskModel: taskModel(
                            id: widget.TaskModel.id,
                            isDone: widget.TaskModel.isDone,
                            title: controller.text,
                            datetime: datetime,
                            level: value?.name),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: state is EditTaskLoading ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ): Text(
                      "Edit Task",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
