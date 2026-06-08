import 'package:rafiq/features/authentication/data/models/LoginRequest.dart';
import 'package:rafiq/features/authentication/data/models/LoginResponse.dart';
import 'package:rafiq/features/authentication/data/models/RegisterRequest.dart';
import 'package:rafiq/features/authentication/data/models/RegisterResponse.dart';
import 'package:rafiq/features/authentication/data/models/ResetPasswordRequest.dart';
import 'package:rafiq/features/authentication/data/models/ResetpasswordResponse.dart';

import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp+response.dart';
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
