import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/model/todo_appstate.dart';

class TaskFilterToggle extends StatefulWidget {
  @override
  _TaskFilterToggleState createState() => _TaskFilterToggleState();
}

class _TaskFilterToggleState extends State<TaskFilterToggle> {
  List<bool> _isToggleSelection = List.generate(3, (_) => false);

  dynamic _listItem = (TaskListFilter listFilter) {
    return List.generate(3, (index) {
      switch (index) {
        case 0:
          return listFilter == TaskListFilter.all;
        case 1:
          return listFilter == TaskListFilter.completed;
        case 2:
          return listFilter == TaskListFilter.active;
        default:
          return false;
      }
    });
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoAppState>(
      builder: (context, taskData, child) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ToggleButtons(
            selectedBorderColor: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
            borderColor: Colors.white,
            fillColor: Colors.black,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'All',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Completed',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Active',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onPressed: (int index) {
              TaskListFilter currentFliter;

              if (index == 0) {
                currentFliter = TaskListFilter.all;
              } else if (index == 1) {
                currentFliter = TaskListFilter.completed;
              } else if (index == 2) {
                currentFliter = TaskListFilter.active;
              }

              taskData.listFilter = currentFliter;
            },
            isSelected: _listItem(taskData.listFilter),
          ),
        ],
      ),
    );
  }
}
