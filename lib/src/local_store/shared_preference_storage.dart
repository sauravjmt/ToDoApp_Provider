import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/src/local_store/shared_preference.dart';
import 'package:todo_app/src/model/todo_entity.dart';

class SharedPreferenceStorage {
  final LocalSharedPreference store;
  final String key;

  final JsonCodec codec;

  SharedPreferenceStorage(this.key, this.store, [this.codec = json]);

  Future<bool> saveTodo(List<TodoEntity> todos) {
    return store.setString(
      key,
      codec.encode({
        'todo': todos.map((todo) => todo.toJson()).toList(),
      }),
    );
  }

  Future<List<TodoEntity>> loadTodo() async {
    return codec
        .decode(store.getString(key))['todo']
        .cast<Map<String, Object>>()
        .map<TodoEntity>(TodoEntity.fromJson)
        .toList(growable: false);
  }
}
