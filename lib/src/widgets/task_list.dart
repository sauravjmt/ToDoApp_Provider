import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/src/model/todo_appstate.dart';
import 'package:todo_app/src/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoAppState>(
      builder: (context, taskData, child) {
        final todoData = taskData.taskListFliter;
        final isLoading = taskData.isLoading;
        return isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) {
                  final task = todoData[index];
                  return TaskTile(
                    taskTitle: task.task,
                    taskSubTitle: task.note,
                    isChecked: task.complete,
                    checkboxCallback: (checkboxState) {
                      Provider.of<TodoAppState>(context, listen: false)
                          .updateTodo(task.copy(complete: checkboxState));
                    },
                    longPressCallback: () {
                      Provider.of<TodoAppState>(context, listen: false)
                          .removeTodo(task);
                    },
                  );
                },
                itemCount: todoData.length,
              );
      },
    );
  }
}
