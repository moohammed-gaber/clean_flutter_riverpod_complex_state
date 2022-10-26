import 'package:riverpod_test/exceptions/exceptions.dart';

class LoginResult {}

class LoginSuccess extends LoginResult {}

class LoginFailure extends LoginResult {
  final Failure failure;

  LoginFailure(this.failure);
}

class ViewModelState {
  final int counter;
  final int selectedIndex;
  final String userName;
  final String password;
  final LoginResult? loginResult;

  ViewModelState({
    required this.selectedIndex,
    required this.counter,
    required this.userName,
    required this.password,
    required this.loginResult,
  });

  ViewModelState copyWith({
    int? counter,
    int? selectedIndex,
    String? userName,
    String? password,
    LoginResult? loginResult,
  }) {
    return ViewModelState(
      counter: counter ?? this.counter,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      loginResult: loginResult,
    );
  }

  // initial
  factory ViewModelState.initial() => ViewModelState(
      loginResult: null,
      counter: 1,
      selectedIndex: 0,
      userName: '',
      password: '');

// copy with

}
