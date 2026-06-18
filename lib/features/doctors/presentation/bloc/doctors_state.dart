part of 'doctors_cubit.dart';

abstract class DoctorsState {}

class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final List<DoctorEntity> doctors;
  DoctorsLoaded(this.doctors);
}

class DoctorsError extends DoctorsState {
  final String message;
  DoctorsError(this.message);
}