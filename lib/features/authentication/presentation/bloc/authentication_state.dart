part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationLoading extends AuthenticationState {}

class SendResetOtpSuccess extends AuthenticationState {
  final String message;

  const SendResetOtpSuccess({required this.message});
}

class AuthenticationLoaded extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class VerifyResetOtpSuccess extends AuthenticationState {
  final String message;

  const VerifyResetOtpSuccess({required this.message});
}

class ResetPassSuccess extends AuthenticationState {
  const ResetPassSuccess({required this.message});
  final String message;
}

class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
