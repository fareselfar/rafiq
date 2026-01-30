part of 'specialization_cubit.dart';

abstract class SpecializationState extends Equatable {
  const SpecializationState();

  @override
  List<Object> get props => [];
}

class SpecializationInitial extends SpecializationState {
  const SpecializationInitial();
}

class SpecializationLoading extends SpecializationState {}

class SpecializationLoaded extends SpecializationState {}

class SpecializationError extends SpecializationState {
  final String message;
  const SpecializationError(this.message);

  @override
  List<Object> get props => [message];
}
