import 'package:flutter/foundation.dart';
import 'package:p1_mobile_app/model/data/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepo = AuthRepository();

  Future<bool> login(String email, String password) {
    return _authRepo.login(email, password);
  }

  Future<bool> register(String email, String password) {
    return _authRepo.register(email, password);
  }

  Future<bool> logout() {
    return _authRepo.logout();
  }

  bool isLoggedIn() {
    return _authRepo.isLoggedIn();
  }
}
