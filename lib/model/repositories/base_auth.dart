abstract class BaseAuth {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
  bool isLoggedIn();
  Future<bool> logout();
}
