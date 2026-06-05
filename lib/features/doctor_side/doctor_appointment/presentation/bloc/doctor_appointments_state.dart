// lib/features/doctor_side/doctor_appointments/presentation/cubit/doctor_appointments_state.dart

part of 'doctor_appointments_cubit.dart';

abstract class DoctorAppointmentsState extends Equatable {
  const DoctorAppointmentsState();
  @override
  List<Object?> get props => [];
}

class DoctorAppointmentsInitial extends DoctorAppointmentsState {
  const DoctorAppointmentsInitial();
}

class DoctorAppointmentsLoading extends DoctorAppointmentsState {
  const DoctorAppointmentsLoading();
}

class DoctorAppointmentsLoaded extends DoctorAppointmentsState {
  final WeeklyScheduleEntity schedule;
  final DateTime selectedDay;
  final AppointmentSlotEntity? selectedSlot; 
  final bool isCancellingDay;
  final bool isSlotActionLoading;

  const DoctorAppointmentsLoaded({
    required this.schedule,
    required this.selectedDay,
    this.selectedSlot,
    this.isCancellingDay = false,
    this.isSlotActionLoading = false,
  });

  DoctorAppointmentsLoaded copyWith({
    WeeklyScheduleEntity? schedule,
    DateTime? selectedDay,
    AppointmentSlotEntity? selectedSlot,
    bool clearSelectedSlot = false,
    bool? isCancellingDay,
    bool? isSlotActionLoading,
  }) {
    return DoctorAppointmentsLoaded(
      schedule: schedule ?? this.schedule,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedSlot: clearSelectedSlot ? null : selectedSlot ?? this.selectedSlot,
      isCancellingDay: isCancellingDay ?? this.isCancellingDay,
      isSlotActionLoading: isSlotActionLoading ?? this.isSlotActionLoading,
    );
  }

  @override
  List<Object?> get props => [
        schedule,
        selectedDay,
        selectedSlot,
        isCancellingDay,
        isSlotActionLoading,
      ];
}

class DoctorAppointmentsError extends DoctorAppointmentsState {
  final String message;
  const DoctorAppointmentsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DoctorAppointmentsActionSuccess extends DoctorAppointmentsState {
  final String message;
  const DoctorAppointmentsActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
