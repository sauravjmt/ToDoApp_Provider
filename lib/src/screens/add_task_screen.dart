import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/model/app_state.dart';
import 'package:todo_app/src/model/todo_appstate.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final textInputController = TextEditingController();
  bool _isValidated = false;

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle, notes = "";
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: textInputController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "add task....",
                  labelStyle: TextStyle(
                    fontSize: 30.0,
                    color: Colors.lightBlueAccent,
                  ),
                  errorText:
                      _isValidated ? "Please add some task title" : null),
              textAlign: TextAlign.start,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightBlueAccent,
                  ),
                  labelText: 'Additional notes'),
              textAlign: TextAlign.center,
              onChanged: (newText) {
                notes = newText;
              },
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                if (textInputController.text.isEmpty) {
                  setState(() {
                    _isValidated = true;
                  });
                } else {
                  setState(() {
                    _isValidated = false;
                  });
                  Provider.of<TodoAppState>(context, listen: false)
                      .addTodo(Todo(textInputController.text, note: notes));

                  Navigator.pop(context);
                }
                //Provider.of<TaskData>(context).addTask(newTaskTitle);
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}
