class TodoEntity {
  final String task;
  final String id;
  final String note;
  final bool complete;

  TodoEntity(this.task, this.id, this.note, this.complete);

  @override
  String toString() {
    return 'TodoEntity{task: $task, id: $id, note: $note, complete: $complete}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          task == other.task &&
          id == other.id &&
          note == other.note &&
          complete == other.complete;

  @override
  int get hashCode =>
      task.hashCode ^ id.hashCode ^ note.hashCode ^ complete.hashCode;

  Map<String, Object> toJson() {
    return {
      'complete': complete,
      'task': task,
      'note': note,
      'id': id,
    };
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json['task'] as String,
      json['id'] as String,
      json['note'] as String,
      json['complete'] as bool,
    );
  }
}
