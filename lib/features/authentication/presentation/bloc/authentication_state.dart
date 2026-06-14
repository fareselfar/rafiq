part of 'authentication_cubit.dart';

// ─── Enum للـ Role ────────────────────────────────────────────────────────────
enum UserRole { patient, doctor }

// ─── Base State ───────────────────────────────────────────────────────────────
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

// ─── Initial ──────────────────────────────────────────────────────────────────
class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

// ─── Loading ──────────────────────────────────────────────────────────────────
class AuthenticationLoading extends AuthenticationState {}

// ─── Register Success (يحمل الـ role عشان نعرف نروح فين) ─────────────────────
class RegisterSuccess extends AuthenticationState {
  final UserRole role;
  const RegisterSuccess({required this.role});

  @override
  List<Object?> get props => [role];
}

// ─── Login Success ────────────────────────────────────────────────────────────
class LoginSuccess extends AuthenticationState {
  final UserRole role;
  const LoginSuccess({required this.role});

  @override
  List<Object?> get props => [role];
}

// ─── OTP ──────────────────────────────────────────────────────────────────────
class SendResetOtpSuccess extends AuthenticationState {
  final String message;
  const SendResetOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class VerifyResetOtpSuccess extends AuthenticationState {
  final String message;
  const VerifyResetOtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─── Reset Password ───────────────────────────────────────────────────────────
class ResetPassSuccess extends AuthenticationState {
  final String message;
  const ResetPassSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─── Error ────────────────────────────────────────────────────────────────────
class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);

  @override
  List<Object?> get props => [message];
}
