part of 'doctor_appointments_cubit.dart';

abstract class DoctorAppointmentsState extends Equatable {
  const DoctorAppointmentsState();

  @override
  List<Object> get props => [];
}

class DoctorAppointmentsInitial extends DoctorAppointmentsState {
  const DoctorAppointmentsInitial();
}

class DoctorAppointmentsLoading extends DoctorAppointmentsState {}

class DoctorAppointmentsLoaded extends DoctorAppointmentsState {}

class DoctorAppointmentsError extends DoctorAppointmentsState {
  final String message;
  const DoctorAppointmentsError(this.message);

  @override
  List<Object> get props => [message];
}
