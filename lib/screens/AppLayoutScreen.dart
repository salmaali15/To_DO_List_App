import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'doneTasks.dart';
import 'inProgressTasks.dart';

class appLayout extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _appLayout();
}

class _appLayout extends State<appLayout>{
  List<Widget> screenList =[
    Inprogresstasks(),
    Donetasks(),
  ];
  int currentIndx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[currentIndx],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blueGrey[700],
        onTap: (index){
          currentIndx = index;
          setState(() {

          });
        },
        currentIndex: currentIndx,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
            ),
            label: "In Progress",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.task_alt,
              ),
              label: "Done Tasks"
          ),
        ],
      ),
    );
  }

}