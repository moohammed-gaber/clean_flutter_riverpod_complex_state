import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  const Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  Todo copyWith({
    int? userId,
    int? id,
    String? title,
    bool? completed,
  }) {
    return Todo(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      userId: map['userId'].toInt() as int,
      id: map['id'].toInt() as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  @override
  List<Object> get props => [userId, id, title, completed];
}
