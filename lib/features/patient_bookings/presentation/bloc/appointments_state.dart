import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';

abstract class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsLoaded extends AppointmentsState {
  final List<PatientAppointmentEntity> appointments;
  AppointmentsLoaded(this.appointments);
}

class AppointmentsError extends AppointmentsState {
  final String message;
  AppointmentsError(this.message);
}

// Details
class AppointmentDetailsLoading extends AppointmentsState {}

class AppointmentDetailsLoaded extends AppointmentsState {
  final AppointmentDetailsEntity details;
  AppointmentDetailsLoaded(this.details);
}

// Actions
class CancelInProgress extends AppointmentsState {}

class CancelSuccess extends AppointmentsState {}

class RescheduleInProgress extends AppointmentsState {}

class RescheduleSuccess extends AppointmentsState {}

class ActionError extends AppointmentsState {
  final String message;
  ActionError(this.message);
}