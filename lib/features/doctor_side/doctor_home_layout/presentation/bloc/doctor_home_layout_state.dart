part of 'doctor_home_layout_cubit.dart';

abstract class DoctorHomeLayoutState extends Equatable {
  const DoctorHomeLayoutState();

  @override
  List<Object> get props => [];
}

class DoctorHomeLayoutInitial extends DoctorHomeLayoutState {
  const DoctorHomeLayoutInitial();
}

class DoctorHomeLayoutLoading extends DoctorHomeLayoutState {}

class DoctorHomeLayoutLoaded extends DoctorHomeLayoutState {}

class DoctorHomeLayoutError extends DoctorHomeLayoutState {
  final String message;
  const DoctorHomeLayoutError(this.message);

  @override
  List<Object> get props => [message];
}
