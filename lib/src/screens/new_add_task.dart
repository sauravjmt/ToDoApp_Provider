import 'package:flutter/material.dart';

class NewAddTask extends StatefulWidget {
  @override
  _NewAddTaskState createState() => _NewAddTaskState();
}

class _NewAddTaskState extends State<NewAddTask> {
  final _formKey = GlobalKey<FormState>();
  final _titleEditingController = TextEditingController();
  final _notesEditingController = TextEditingController();

  @override
  void dispose() {
    _titleEditingController.dispose();
    _notesEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    final textTheme = Theme.of(context).textTheme;
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
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _titleEditingController,
                  decoration: InputDecoration(
                    hintText: 'What needs to be done?',
                  ),
                  style: textTheme.headline1,
                  autofocus: true,
                  validator: (val) {
                    return val.trim().isEmpty ? "Please enter some text" : null;
                  },
                ),
                TextFormField(
                  controller: _notesEditingController,
                  style: textTheme.subtitle1,
                  decoration: InputDecoration(hintText: 'Additional Notes...'),
                  maxLines: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
