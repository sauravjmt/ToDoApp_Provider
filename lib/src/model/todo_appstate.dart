import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/src/model/app_state.dart';
import 'package:todo_app/src/repository/local_storage_repository.dart';

enum TaskListFilter { all, active, completed }

class TodoAppState extends ChangeNotifier {
  bool _isLoading = false;
  String data;
  List<Todo> _todo;
  TaskListFilter _listFilter;
  final LocalStorageRepository localStorageRepository;

  TaskListFilter get listFilter => _listFilter;

  set listFilter(TaskListFilter value) {
    _listFilter = value;

    notifyListeners();
  }

  TodoAppState(
      {@required this.localStorageRepository,
      TaskListFilter listFilter,
      List<Todo> todo})
      : _todo = todo ?? [],
        _listFilter = listFilter ?? TaskListFilter.all;

  bool get isLoading => _isLoading;

  UnmodifiableListView<Todo> get todo => UnmodifiableListView(_todo);

  List<Todo> get taskListFliter {
    return _todo.where((element) {
      switch (_listFilter) {
        case TaskListFilter.completed:
          return element.complete;
        case TaskListFilter.active:
          return !element.complete;
        case TaskListFilter.all:
        default:
          return true;
      }
    }).toList();
  }

  Future loadTodo() {
    _isLoading = true;
    notifyListeners();
    return localStorageRepository.loadTodo().then((todoList) {
      print('Load From Pref===>$todoList');
      _todo.addAll(todoList.map(Todo.fromEntity));
      _isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void updateTodo(Todo todo) {
    assert(todo != null);
    assert(todo.id != null);
    var oldTodo = _todo.firstWhere((element) => todo.id == element.id);
    print('oldTodo==>$oldTodo');

    int replaceIndex = _todo.indexOf(oldTodo);

    _todo.replaceRange(replaceIndex, replaceIndex + 1, [todo]);

    var afterReplace = _todo.firstWhere((element) => todo.id == element.id);

    print('oldTodo==>$afterReplace');

    notifyListeners();

    _updateItem();
  }

  void addTodo(Todo todo) {
    _todo.add(todo);
    notifyListeners();
    _updateItem();
  }

  int get totalTask => _todo.length;

  void removeTodo(Todo todo) {
    _todo.removeWhere((element) => element.id == todo.id);
    notifyListeners();
    _updateItem();
  }

  _updateItem() {
    localStorageRepository.saveTodo(_todo.map((e) => e.toEntity()).toList());
  }
}
