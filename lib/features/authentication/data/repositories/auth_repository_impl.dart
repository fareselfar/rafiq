import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:rafiq/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
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
import 'package:rafiq/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  // ─── Register ────────────────────────────────────────────────────────────────
  // السيرفر بيرجع: { token, email, name, role, expiresAt }
  @override
  Future<Either<Failure, RegisterResponse>> register(
    RegisterRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.register(request);

      // حفظ التوكن والـ role (role جاي من السيرفر مباشرة "Patient" أو "Doctor")
      await _localDataSource.saveToken(token: response.token);
      await _localDataSource.saveRole(role: response.role);

      return Right(response);
    } on RemoteException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on LocalException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // ─── Login ───────────────────────────────────────────────────────────────────
  // السيرفر بيرجع نفس الـ shape: { token, email, name, role, expiresAt }
  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
    try {
      final response = await _remoteDataSource.login(request);
      print("LOGIN ROLE => ${response.role}");
      // response.role و response.token ممكن يكونوا null → نستخدم ?? ''
      await _localDataSource.saveToken(token: response.token ?? '');
      final decodedToken = JwtDecoder.decode(response.token ?? '');

      final role =
          decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
      await _localDataSource.saveRole(role: role ?? '');
      print("SAVED ROLE => ${await _localDataSource.getRole()}");
      return Right(response);
    } on RemoteException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on LocalException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // ─── Verify OTP ──────────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, VerifyResetOtpResponse>> verifyResetOtp(
    VerifyResetOtpRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.verifyResetOtp(request);
      return Right(response);
    } on RemoteException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // ─── Send OTP ────────────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, SendResetOtpResponse>> sendResetOtp(
    SendResetOtpRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.sendResetOtp(request);
      return Right(response);
    } on RemoteException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  // ─── Reset Password ──────────────────────────────────────────────────────────
  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.restPassword(request: request);
      return Right(response);
    } on RemoteException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
