import 'package:dio/dio.dart';
import 'package:riverpod_test/exceptions/failures.dart';

abstract class IAuthRepo {
  Future<void> login(String userName, String password);
}

class AuthRepo implements IAuthRepo{
  AuthRepo(this.dio);

  final Dio dio;

  // login
  Future<void> login(String userName, String password) async {
    final delay = await Future.delayed(Duration(seconds: 1));
    if (userName == 'admin' && password == 'admin') {
      return;
    }
    throw InvalidEmailOrPasswordFailure();
  }
}
