abstract class AuthLocalDataSource {
  Future<void> saveToken({required String token});
  Future<String> getToken();
  Future<void> saveRole({required String role});
  Future<String> getRole();
}
