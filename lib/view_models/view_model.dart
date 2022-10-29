import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/exceptions/failures.dart';
import 'package:riverpod_test/repos/auth_repo.dart';
import 'package:riverpod_test/view_models/state.dart';

import 'events.dart';

class ViewModel extends StateNotifier<ViewModelState> implements Events {
  final IAuthRepo authRepo;

  ViewModel(this.authRepo) : super(ViewModelState.initial());

  @override
  void increment() {
    final newState = state.copyWith(
      counter: state.counter + 1,
    );
    state = newState;
  }

  @override
  void selectIndex(int index) {
    final newState = state.copyWith(
      selectedIndex: index,
    );
    state = newState;
  }

  @override
  void login() async {
    try {
      await authRepo.login(state.userName, state.password);
      state = state.copyWith(loginResult: LoginSuccess());
    } on InvalidEmailOrPasswordFailure catch (e) {
      final newState = state.copyWith();
      state = state.copyWith(loginResult: LoginFailure(e));
    }
  }

  @override
  void onChangedUserName(String value) {
    final newState = state.copyWith(
      userName: value,
    );
    state = newState;
  }

  @override
  void onChangedPassword(String value) {
    final newState = state.copyWith(
      password: value,
    );
    state = newState;
  }
}
