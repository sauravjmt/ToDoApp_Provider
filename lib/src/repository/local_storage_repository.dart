import 'package:flutter/cupertino.dart';
import 'package:todo_app/src/local_store/shared_preference_storage.dart';
import 'package:todo_app/src/model/todo_entity.dart';
import 'package:todo_app/src/repository/web_client_mockData.dart';

class LocalStorageRepository {
  final SharedPreferenceStorage preferenceStorage;
  final WebClientMockData webClientMockData;

  const LocalStorageRepository(
      {@required this.preferenceStorage,
      this.webClientMockData = const WebClientMockData()});

  Future<List<TodoEntity>> loadTodo() async {
    try {
      return await preferenceStorage.loadTodo();
    } catch (e) {
      print("data From Web Client");
      final todos = await webClientMockData.loadTodo();
      preferenceStorage.saveTodo(todos);

      return todos;
    }
  }

  Future saveTodo(List<TodoEntity> todo) {
    print('save to pref===>$todo');
    return Future.wait<dynamic>([
      preferenceStorage.saveTodo(todo),
      webClientMockData.saveTodos(todo),
    ]);
  }
}
