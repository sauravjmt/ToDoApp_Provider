import 'package:todo_app/src/model/todo_entity.dart';
import 'package:uuid/uuid.dart';

class AppState {
  bool isLoading;
  String data;
  List<Todo> todos;

  AppState({
    this.isLoading = false,
    this.todos = const [],
  });

  factory AppState.loading() => AppState(isLoading: true);

  List<Todo> getData() => todos;
}

class Todo {
  bool complete;
  String id;
  String note;
  String task;

  Todo(
    this.task, {
    this.complete = false,
    this.note = "",
    String id,
  }) : id = id ?? Uuid().v4();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          id == other.id &&
          note == other.note &&
          task == other.task;

  @override
  int get hashCode =>
      complete.hashCode ^ id.hashCode ^ note.hashCode ^ task.hashCode;

  @override
  String toString() {
    return 'Todo{complete: $complete, id: $id, note: $note, task: $task}';
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(entity.task,
        complete: entity.complete ?? false,
        note: entity.note,
        id: entity.id ?? Uuid().v4());
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  Todo copy({bool complete, String id, String task, String note}) {
    return Todo(task ?? this.task,
        complete: complete ?? this.complete,
        note: note ?? this.note,
        id: id ?? this.id);
  }
}
