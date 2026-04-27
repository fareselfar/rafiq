part of 'homee_cubit.dart';

abstract class HomeeState extends Equatable {
  const HomeeState();

  @override
  List<Object> get props => [];
}

class HomeeInitial extends HomeeState {
  const HomeeInitial();
}

class HomeeLoading extends HomeeState {}

class HomeeLoaded extends HomeeState {}

class HomeeError extends HomeeState {
  final String message;
  const HomeeError(this.message);

  @override
  List<Object> get props => [message];
}
