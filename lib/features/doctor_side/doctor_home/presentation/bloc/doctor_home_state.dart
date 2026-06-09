// lib/features/doctor_side/doctor_home/presentation/cubit/doctor_home_state.dart

part of 'doctor_home_cubit.dart';

abstract class DoctorHomeState extends Equatable {
  const DoctorHomeState();

  @override
  List<Object?> get props => [];
}

class DoctorHomeInitial extends DoctorHomeState {
  const DoctorHomeInitial();
}

class DoctorHomeLoading extends DoctorHomeState {
  const DoctorHomeLoading();
}

class DoctorHomeLoaded extends DoctorHomeState {
  final DoctorHomeEntity data;

  const DoctorHomeLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class DoctorHomeError extends DoctorHomeState {
  final String message;

  const DoctorHomeError(this.message);

  @override
  List<Object?> get props => [message];
}
