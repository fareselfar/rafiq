import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/authentication/data/models/login_request.dart';
import 'package:rafiq/features/authentication/data/models/login_response.dart';
import 'package:rafiq/features/authentication/data/models/register_request.dart';
import 'package:rafiq/features/authentication/data/models/register_response.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_pesponse.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> register(RegisterRequest request);
  Future<Either<Failure, LoginResponse>> login(LoginRequest request);
  Future<Either<Failure, VerifyResetOtpResponse>> verifyResetOtp(
    VerifyResetOtpRequest request,
  );
  Future<Either<Failure, SendResetOtpResponse>> sendResetOtp(
    SendResetOtpRequest request,
  );
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  );
}
