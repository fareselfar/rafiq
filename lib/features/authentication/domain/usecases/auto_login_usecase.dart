import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_local_data_source.dart';

class AutoLoginUseCase {
  final AuthLocalDataSource _localDataSource;

  const AutoLoginUseCase({required AuthLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  Future<AutoLoginResult> call() async {
    final token = await _localDataSource.getToken();

    if (token == null || token.isEmpty) {
      return AutoLoginResult.notLoggedIn;
    }

    final isExpired = JwtDecoder.isExpired(token);
    if (isExpired) {
      await _localDataSource.clearAll();
      return AutoLoginResult.tokenExpired;
    }

    final role = await _localDataSource.getRole();
    if (role == null || role.isEmpty) {
      return AutoLoginResult.notLoggedIn;
    }

    return role.toLowerCase() == 'doctor'
        ? AutoLoginResult.doctorLoggedIn
        : AutoLoginResult.patientLoggedIn;
  }
}

enum AutoLoginResult {
  notLoggedIn,
  tokenExpired,
  patientLoggedIn,
  doctorLoggedIn,
}