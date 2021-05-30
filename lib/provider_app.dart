import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/model/todo_appstate.dart';
import 'package:todo_app/src/repository/local_storage_repository.dart';
import 'package:todo_app/src/screens/home_screen.dart';
import 'package:todo_app/src/screens/task_screen.dart';

class ProviderApp extends StatelessWidget {
  final LocalStorageRepository localStorage;

  const ProviderApp({@required this.localStorage});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          TodoAppState(localStorageRepository: localStorage)..loadTodo(),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
