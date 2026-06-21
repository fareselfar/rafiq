part of 'doctors_cubit.dart';

abstract class DoctorsState {}

class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final List<DoctorEntity> doctors;
  final DoctorFilter currentFilter;
  DoctorsLoaded(this.doctors, this.currentFilter);
}

class DoctorsError extends DoctorsState {
  final String message;
  DoctorsError(this.message);
}