import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/model/todo_appstate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoData = Provider.of<TodoAppState>(context).todo;
    // print('data=====>$todoData');
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo with Provider"),
      ),
      body: Consumer<TodoAppState>(
        builder: (context, todo, child) {
          final isLoading = todo.isLoading;
          final todoData = todo.todo;
          return isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Container(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      final singleTodo = todoData[index];
                      return ListTile(
                        title: Text("${singleTodo.task}"),
                        subtitle: Text("${singleTodo.note}"),
                        trailing: Checkbox(
                          value: singleTodo.complete,
                          onChanged: (newValue) {
                            Provider.of<TodoAppState>(context, listen: false)
                                .updateTodo(
                                    singleTodo.copy(complete: newValue));
                          },
                        ),
                      );
                    }),
                    itemCount: todoData.length,
                  ),
                ));
        },
      ),
    );
  }
}
