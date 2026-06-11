import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_side/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:rafiq/features/patient_side/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/login_request.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/register_request.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/reset_password_pesponse.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/send_otp_response.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/verify_otp_response.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/patient_side/authentication/domain/entities/auth_entity.dart';
import 'package:rafiq/features/patient_side/authentication/domain/repositories/auth_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepoImpl implements AuthenticationRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;

  AuthRepoImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });
  @override
  Future<Either<Failures, AuthEntity>> register({
    required RegisterRequest request,
  }) async {
    try {
      var response = await authRemoteDataSource.register(request);
      authLocalDataSource.saveToken(token: response.token!);
      return right(response.toAuthEntity());
    } on AuthExpetions catch (exp) {
      return left(Failures(message: exp.message));
    }
  }

  @override
  Future<Either<Failures, AuthEntity>> login({
    required LoginRequest request,
    req,
  }) async {
    try {
      var response = await authRemoteDataSource.login(request);
      authLocalDataSource.saveToken(token: response.token!);
      final decodedToken = JwtDecoder.decode(response.token!);
      final role =
          decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

      print('ROLE => $role');
      await authLocalDataSource.saveRole(role: role);
      return right(response.toAuthEntity());
    } on AuthExpetions catch (exp) {
      return left(Failures(message: exp.message));
    }
  }

  @override
  Future<Either<Failures, VerifyResetOtpResponse>> verifyResetOtp({
    required VerifyResetOtpRequest request,
  }) async {
    try {
      final result = await authRemoteDataSource.verifyResetOtp(request);

      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failures, SendResetOtpResponse>> sendResetOtp({
    required SendResetOtpRequest request,
  }) async {
    try {
      final result = await authRemoteDataSource.sendResetOtp(request);

      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }

  @override
  Future<Either<Failures, ResetPasswordResponse>> resetPassword({
    required ResetPasswordRequest request,
  }) async {
    try {
      final result = await authRemoteDataSource.restPassword(request: request);
      return Right(result);
    } on RemoteException catch (e) {
      return Left(Failures(message: e.message));
    }
  }
}
