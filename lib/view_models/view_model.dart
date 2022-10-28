import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/repos/auth_repo.dart';
import 'package:riverpod_test/exceptions/failures.dart';
import 'package:riverpod_test/view_models/state.dart';

import 'events.dart';

class ViewModel extends StateNotifier<ViewModelState> implements Events {
  final IAuthRepo authRepo;

  ViewModel(this.authRepo) : super(ViewModelState.initial());

  @override
  void increment() => state = state.copyWith(
        counter: state.counter + 1,
      );

  @override
  void selectIndex(int index) => state = state.copyWith(
        selectedIndex: index,
      );

  @override
  void login() async {
    try {
      await authRepo.login(state.userName, state.password);
      state = state.copyWith(loginResult: LoginSuccess());
    } on InvalidEmailOrPasswordFailure catch (e) {
      state = state.copyWith(loginResult: LoginFailure(e));
    }
  }

  @override
  void onChangedUserName(String value) => state = state.copyWith(
        userName: value,
      );

  @override
  void onChangedPassword(String value) => state = state.copyWith(
        password: value,
      );
}
