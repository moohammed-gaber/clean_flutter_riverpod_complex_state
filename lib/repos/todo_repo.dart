import 'package:riverpod_test/models/todo.dart';
import 'package:dio/dio.dart';

abstract class ITodoRepo {
  Future<List<Todo>> getTodos();
}

class TodoRepo implements ITodoRepo {
  TodoRepo(this.dio);

  final Dio dio;

  @override
  Future<List<Todo>> getTodos() async {
    final result = await dio.get('https://jsonplaceholder.typicode.com/todos');
    return (result.data as List).map((e) => Todo.fromMap(e)).toList();
  }
}
