import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/repos/auth_repo.dart';
import 'package:riverpod_test/exceptions/failures.dart';
import 'package:riverpod_test/view_models/state.dart';

class ViewModel extends StateNotifier<ViewModelState> {
  final IAuthRepo authRepo;

  ViewModel(this.authRepo) : super(ViewModelState.initial());

  void increment() {
    final newState = state.copyWith(
      counter: state.counter + 1,
    );
    print(newState.counter);
    state = newState;
  }

  void selectIndex(int index) {
    final newState = state.copyWith(
      selectedIndex: index,
    );
    state = newState;
  }

  void login() async {
    try {
      final result = await authRepo.login(state.userName, state.password);
      state = state.copyWith(loginResult: LoginSuccess());
    } on InvalidEmailOrPasswordFailure catch (e) {
      final newState = state.copyWith();
      state = state.copyWith(loginResult: LoginFailure(e));
    }
  }

  void onChangedUserName(String value) {
    final newState = state.copyWith(
      userName: value,
    );
    state = newState;
  }

  void onChangedPassword(String value) {
    final newState = state.copyWith(
      password: value,
    );
    state = newState;
  }
}
