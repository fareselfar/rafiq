import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefs implements AuthLocalDataSource {
  // ─── Save Token ───────────────────────────────────────────────────────────
  @override
  Future<void> saveToken({required String token}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.tokenKey, token);
    } catch (_) {
      throw LocalException(message: 'فشل حفظ التوكن');
    }
  }

  // ─── Get Token ────────────────────────────────────────────────────────────
  @override
  Future<String> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(AppConstants.tokenKey) ?? '';
    } catch (_) {
      throw LocalException(message: 'فشل جلب التوكن');
    }
  }

  // ─── Save Role ────────────────────────────────────────────────────────────
  @override
  Future<void> saveRole({required String role}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.roleKey, role);
    } catch (_) {
      throw LocalException(message: 'فشل حفظ الدور');
    }
  }

  // ─── Get Role ─────────────────────────────────────────────────────────────
  @override
  Future<String> getRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(AppConstants.roleKey) ?? '';
    } catch (_) {
      throw LocalException(message: 'فشل جلب الدور');
    }
  }

  // ─── Clear All (logout) ───────────────────────────────────────────────────
  @override
  Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConstants.tokenKey);
      await prefs.remove(AppConstants.roleKey);
    } catch (_) {
      throw LocalException(message: 'فشل مسح البيانات المحلية');
    }
  }

  // ─── Is Logged In ─────────────────────────────────────────────────────────
  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await getToken();
      return token.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
