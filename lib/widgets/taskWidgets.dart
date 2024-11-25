import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:to_do_list_app/widgets/task_action_button_widget.dart';


import '../models/taskModel.dart';

class taskWidgets extends StatelessWidget{

  final taskModel TaskModel;
  final void Function()? removePress;
  final void Function()? editPress;
  final void Function()? donePress;


  const taskWidgets({
    super.key,
    required this.TaskModel, this.removePress, this.editPress, this.donePress,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xffE5E5E5),
            blurRadius: 9.39,
            offset: Offset.zero,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( TaskModel.title?? "Type your task title",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    TaskModel.datetime !=null? Jiffy.parse(TaskModel.datetime ?? "").yMMMMEEEEdjm: "No date",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 60,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(TaskModel.level?? "No level selected",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TaskModel.isDone == true ?Icon(Icons.task_alt,color: Colors.green,):
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  taskActionButton(
                    iconPath: 'assets/svg/edit.svg',
                    onPressed: editPress,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  taskActionButton(
                    iconPath: 'assets/svg/delete.svg',
                    onPressed: removePress,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero
                  ),
                  onPressed: donePress,
                  child: Text(
                    "Task Done",
                    style: TextStyle(
                      color: Colors.blueGrey[800],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}