// presentation/bloc/book_appointment_state.dart
part of 'book_appointment_cubit.dart';

abstract class BookAppointmentState {}
class BookAppointmentInitial extends BookAppointmentState {}
class SlotsLoading extends BookAppointmentState {}
class SlotsLoaded extends BookAppointmentState {
  final List<SlotEntity> slots;
  final int? selectedSlotId;
  SlotsLoaded(this.slots, {this.selectedSlotId});
}
class BookingInProgress extends BookAppointmentState {}
class BookingSuccess extends BookAppointmentState {
  BookingSuccess();
}
class BookAppointmentError extends BookAppointmentState {
  final String message;
  BookAppointmentError(this.message);
}