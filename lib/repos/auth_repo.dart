import 'package:dio/dio.dart';
import 'package:riverpod_test/exceptions/failures.dart';

abstract class IAuthRepo {
  Future<void> login(String userName, String password);
}

class AuthRepo implements IAuthRepo {
  AuthRepo(this.dio);

  final Dio dio;

  @override
  Future<void> login(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (userName == 'admin' && password == 'admin') {
      return;
    }
    throw InvalidEmailOrPasswordFailure();
  }
}
