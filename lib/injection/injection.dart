import 'package:riverpod_test/models/todo.dart';
import 'package:riverpod_test/repos/todo_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/repos/auth_repo.dart';
import 'package:riverpod_test/view_models/state.dart';
import 'package:riverpod_test/view_models/view_model.dart';

final authProvider = Provider<IAuthRepo>(
  (ref) => AuthRepo(ref.read(dioClientProvider)),
);

final stateProvider = StateNotifierProvider<ViewModel, ViewModelState>(
  (ref) => ViewModel(ref.read(authProvider)),
);

final dioClientProvider = Provider<Dio>(
  (ref) => Dio(),
);

final repoProvider = Provider<ITodoRepo>(
  (ref) => TodoRepo((ref.read(dioClientProvider))),
);

final todosProvider = FutureProvider<List<Todo>>(
  (ref) => ref.read(repoProvider).getTodos(),
);
