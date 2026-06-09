import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/features/authentication/data/models/login_request.dart';
import 'package:rafiq/features/authentication/data/models/register_request.dart';
import 'package:rafiq/features/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/authentication/domain/usecases/login_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/register_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/reset_pass_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/verify_otp_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.verifyResetOtpUseCase,
    required this.sendOtpUsecase,
    required this.resetPassUsecase,
  }) : super(const AuthenticationInitial());
  final ResetPassUsecase resetPassUsecase;
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final VerifyResetOtpUseCase verifyResetOtpUseCase;
  final SendResetOtpUseCase sendOtpUsecase;

  void register(RegisterRequest request) async {
    emit(AuthenticationLoading());
    var result = await registerUsecase(request: request);
    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message));
      },
      (user) {
        emit(AuthenticationLoaded());
      },
    );
  }

  void login(LoginRequest request) async {
    emit(AuthenticationLoading());
    var result = await loginUsecase(request: request);
    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message));
      },
      (user) {
        emit(AuthenticationLoaded());
      },
    );
  }

  Future<void> verifyResetOtp({required VerifyResetOtpRequest request}) async {
    emit(AuthenticationLoading());

    final result = await verifyResetOtpUseCase(request: request);

    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message));
      },
      (response) {
        emit(VerifyResetOtpSuccess(message: response.message));
      },
    );
  }

  Future<void> sendResetOtp({required SendResetOtpRequest request}) async {
    emit(AuthenticationLoading());

    final result = await sendOtpUsecase(request: request);

    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message));
      },
      (response) {
        emit(SendResetOtpSuccess(message: response.message));
      },
    );
  }

  Future<void> resetPass({required ResetPasswordRequest request}) async {
    emit(AuthenticationLoading());
    final result = await resetPassUsecase(request: request);
    result.fold(
      (failure) {
        emit(AuthenticationError(failure.message));
      },
      (success) {
        emit(
          ResetPassSuccess(
            message: success.message ?? 'Password reset successfully.',
          ),
        );
      },
    );
  }
}
