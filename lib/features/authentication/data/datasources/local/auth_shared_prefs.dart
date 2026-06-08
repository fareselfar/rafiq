import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefs implements AuthLocalDataSource {
  @override
  Future<void> saveToken({required String token}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(AppConstants.tokenKey, token);
    } catch (exp) {
      throw LocalException(message: "Failed to save token");
    }
  }

  @override
  Future<String> getToken() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      return sharedPreferences.getString(AppConstants.tokenKey) ?? '';
    } catch (exp) {
      throw LocalException(message: "Failed to get token");
    }
  }

  @override
  Future<void> saveRole({required String role}) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString(AppConstants.roleKey, role);
    } catch (exp) {
      throw LocalException(message: "Failed to save role");
    }
  }

  @override
  Future<String> getRole() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      return sharedPreferences.getString(AppConstants.roleKey) ?? '';
    } catch (exp) {
      throw LocalException(message: "Failed to get role");
    }
  }
}
