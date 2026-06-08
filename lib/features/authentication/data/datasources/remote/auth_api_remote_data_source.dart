import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:rafiq/features/authentication/data/models/LoginRequest.dart';
import 'package:rafiq/features/authentication/data/models/LoginResponse.dart';
import 'package:rafiq/features/authentication/data/models/RegisterRequest.dart';
import 'package:rafiq/features/authentication/data/models/RegisterResponse.dart';
import 'package:rafiq/features/authentication/data/models/ResetPasswordRequest.dart';
import 'package:rafiq/features/authentication/data/models/ResetpasswordResponse.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp+response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_response.dart';

class AuthApiRemoteDataSource implements AuthRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
  @override
  Future<RegiasterResponse> register(RegisterRequest request) async {
    try {
      var response = await dio.post(
        AppConstants.signUpEndpoint,
        data: request.toJson(),
      );

      print('RAW RESPONSE => ${response.data}');
      RegiasterResponse registerResponse = RegiasterResponse.fromJson(
        response.data,
      );
      return registerResponse;
    } catch (exp) {
      String? message;
      if (exp is DioException) {
        message = exp.response?.data?["message"];
      }

      throw RemoteException(message: message ?? "Failed to register");
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      var response = await dio.post(
        AppConstants.signInEndpoint,
        data: request.toJson(),
      );

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);
      return loginResponse;
    } catch (exp) {
      String? message;
      if (exp is DioException) {
        message = exp.response!.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to login");
    }
  }

  @override
  Future<VerifyResetOtpResponse> verifyResetOtp(
    VerifyResetOtpRequest request,
  ) async {
    try {
      final response = await dio.post(
        AppConstants.verifyOtpEndpoint,
        data: request.toJson(),
      );

      return VerifyResetOtpResponse.fromJson(response.data);
    } catch (exp) {
      String? message;
      if (exp is DioException) {
        message = exp.response?.data['message'] ?? 'Failed to verify OTP';
      }
      throw RemoteException(message: message ?? "Failed to verify OTP");
    }
  }

  @override
  Future<SendResetOtpResponse> sendResetOtp(SendResetOtpRequest request) async {
    try {
      final response = await dio.post(
        AppConstants.sendResetOtpEndpoint,
        data: request.toJson(),
      );

      return SendResetOtpResponse.fromJson(response.data);
    } catch (exp) {
      String? message;
      if (exp is DioException) {
        message = exp.response?.data['message'] ?? 'Failed to send OTP';
      }
      throw RemoteException(message: message ?? "Failed to send OTP");
    }
  }

  @override
  Future<ResetPasswordResponse> restPassword({
    required ResetPasswordRequest request,
  }) async {
    try {
      var response = await dio.post(
        AppConstants.resetPasswordEndpoint,
        data: request.toJson(),
      );
      ResetPasswordResponse resetPasswordResponse =
          ResetPasswordResponse.fromJson(response.data);
      return resetPasswordResponse;
    } catch (exp) {
      String? message;
      if (exp is DioException) {
        message = exp.response?.data['message'] ?? 'Failed to reset password';
      }
      throw RemoteException(message: message ?? "Failed to reset password");
    }
  }
}
