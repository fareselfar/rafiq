import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/authentication/data/models/LoginRequest.dart';
import 'package:rafiq/features/authentication/data/models/RegisterRequest.dart';
import 'package:rafiq/features/authentication/data/models/ResetPasswordRequest.dart';
import 'package:rafiq/features/authentication/data/models/ResetpasswordResponse.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp+response.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import '../entities/auth_entity.dart';

abstract class AuthenticationRepository {
  Future<Either<Failures, AuthEntity>> register({
    required RegisterRequest request,
  });
  Future<Either<Failures, AuthEntity>> login({required LoginRequest request});
  Future<Either<Failures, VerifyResetOtpResponse>> verifyResetOtp({
    required VerifyResetOtpRequest request,
  });
  Future<Either<Failures, SendResetOtpResponse>> sendResetOtp({
    required SendResetOtpRequest request,
  });
  Future<Either<Failures, ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest request,
  });
}
