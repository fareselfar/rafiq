import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:rafiq/features/authentication/data/models/login_request.dart';
import 'package:rafiq/features/authentication/data/models/login_response.dart';
import 'package:rafiq/features/authentication/data/models/register_request.dart';
import 'package:rafiq/features/authentication/data/models/register_response.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_pesponse.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_response.dart';

class AuthApiRemoteDataSource implements AuthRemoteDataSource {
  final Dio dio;

  AuthApiRemoteDataSource({required this.dio});

  // ─── Register ─────────────────────────────────────────────────────────────
  // POST /api/Auth/register
  // Body: { name, email, password, role, age?, gender?, specialization?, description?, price? }
  // Response: { token, email, name, role, expiresAt }
  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await dio.post(
        AppConstants.signUpEndpoint,
        data: request.toJson(),
      );
      return RegisterResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (exp) {
      print('STATUS = ${exp.response?.statusCode}');
      print('DATA = ${exp.response?.data}');
      print('HEADERS = ${exp.response?.headers}');
      print('REQUEST = ${request.toJson()}');

      final message = _extractMessage(exp) ?? 'فشل إنشاء الحساب';
      throw RemoteException(message: message);
    }
  }

  // ─── Login ────────────────────────────────────────────────────────────────
  // POST /api/Auth/login
  // Body: { email, password }
  // Response: { token, email, name, role, expiresAt }
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        AppConstants.signInEndpoint,
        data: request.toJson(),
      );
      print("LOGIN RESPONSE => ${response.data}");
      return LoginResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (exp) {
      final message = _extractMessage(exp) ?? 'فشل تسجيل الدخول';
      throw RemoteException(message: message);
    }
  }

  // ─── Verify OTP ───────────────────────────────────────────────────────────
  // POST /api/Auth/verify-otp
  // Body: { code, email }
  @override
  Future<VerifyResetOtpResponse> verifyResetOtp(
    VerifyResetOtpRequest request,
  ) async {
    try {
      final response = await dio.post(
        AppConstants.verifyOtpEndpoint,
        data: request.toJson(),
      );
      return VerifyResetOtpResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (exp) {
      throw RemoteException(
        message: _extractMessage(exp) ?? 'فشل التحقق من الكود',
      );
    }
  }

  // ─── Send OTP ─────────────────────────────────────────────────────────────
  // POST /api/Auth/send-otp
  // Body: { email }
  @override
  Future<SendResetOtpResponse> sendResetOtp(SendResetOtpRequest request) async {
    try {
      final response = await dio.post(
        AppConstants.sendResetOtpEndpoint,
        data: request.toJson(),
      );
      return SendResetOtpResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (exp) {
      throw RemoteException(message: _extractMessage(exp) ?? 'فشل إرسال الكود');
    }
  }

  // ─── Reset Password ───────────────────────────────────────────────────────
  @override
  Future<ResetPasswordResponse> restPassword({
    required ResetPasswordRequest request,
  }) async {
    try {
      final response = await dio.post(
        AppConstants.resetPasswordEndpoint,
        data: request.toJson(),
      );
      return ResetPasswordResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (exp) {
      throw RemoteException(
        message: _extractMessage(exp) ?? 'فشل تغيير كلمة المرور',
      );
    }
  }

  // ─── Helper ───────────────────────────────────────────────────────────────
  String? _extractMessage(DioException exp) {
    try {
      final data = exp.response?.data;
      if (data is Map) return data['message'] as String?;
    } catch (_) {}
    return null;
  }
}
