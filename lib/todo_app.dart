import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/src/local_store/shared_preference.dart';
import 'package:todo_app/src/local_store/shared_preference_storage.dart';
import 'package:todo_app/src/model/app_state.dart';
import 'package:todo_app/src/repository/local_storage_repository.dart';

class TodoApp extends StatefulWidget {
  final LocalStorageRepository localStorage;

  const TodoApp({@required this.localStorage});
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  AppState appState = AppState.loading();
  String data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.localStorage.loadTodo().then((todoLoaded) {
      setState(() {
        appState = AppState(todos: todoLoaded.map(Todo.fromEntity).toList());
        data = "Hello world !!";
      });
    }).catchError((onError) => {
          setState(() {
            appState.isLoading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    print('isLoading....${appState.isLoading}');
    print('${appState.getData().length}');
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
        body: appState.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, index) {
                  final todo = appState.getData()[index];

                  return ListTile(
                    title: Text(todo.task),
                    subtitle: Text(todo.note),
                    trailing: Checkbox(
                      value: todo.complete,
                      activeColor: Colors.lightBlueAccent,
                      onChanged: null,
                    ),
                  );
                },
                itemCount: appState.getData().length,
              ),
      ),
    );
  }
}
