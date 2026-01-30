part of 'doctors_cubit.dart';

abstract class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

class DoctorsInitial extends DoctorsState {
  const DoctorsInitial();
}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {}

class DoctorsError extends DoctorsState {
  final String message;
  const DoctorsError(this.message);

  @override
  List<Object> get props => [message];
}
