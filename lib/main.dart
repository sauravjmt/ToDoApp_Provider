import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/provider_app.dart';
import 'package:todo_app/src/local_store/shared_preference.dart';
import 'package:todo_app/src/local_store/shared_preference_storage.dart';
import 'package:todo_app/src/repository/local_storage_repository.dart';
import 'package:todo_app/todo_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderApp(
    localStorage: LocalStorageRepository(
      preferenceStorage: SharedPreferenceStorage('provider_todo',
          LocalSharedPreference(await SharedPreferences.getInstance())),
    ),
  ));
}
