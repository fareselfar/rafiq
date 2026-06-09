import 'package:rafiq/features/authentication/data/models/login_request.dart';
import 'package:rafiq/features/authentication/data/models/login_response.dart';
import 'package:rafiq/features/authentication/data/models/register_request.dart';
import 'package:rafiq/features/authentication/data/models/register_response.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_pesponse.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';

abstract class AuthRemoteDataSource {
  Future<RegiasterResponse> register(RegisterRequest request);
  Future<LoginResponse> login(LoginRequest request);
  Future<VerifyResetOtpResponse> verifyResetOtp(VerifyResetOtpRequest request);
  Future<SendResetOtpResponse> sendResetOtp(SendResetOtpRequest request);
  Future<ResetPasswordResponse> restPassword({
    required ResetPasswordRequest request,
  });
}
