// presentation/bloc/book_appointment_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/slot_entity.dart';
import '../../domain/usecases/booking_usecases.dart';

part 'book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  final GetAvailableSlotsUseCase getSlotsUseCase;
  final BookAppointmentUseCase bookUseCase;

  BookAppointmentCubit(this.getSlotsUseCase, this.bookUseCase)
      : super(BookAppointmentInitial());

  int? selectedSlotId;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

  Future<void> loadSlots(int doctorId, DateTime date) async {
    selectedDate = date;
    emit(SlotsLoading());
    try {
      final slots = await getSlotsUseCase(doctorId, date);
      emit(SlotsLoaded(slots));
    } catch (e) {
      emit(BookAppointmentError(e.toString()));
    }
  }

  void selectSlot(int slotId) {
    selectedSlotId = slotId;
    final current = state;
    if (current is SlotsLoaded) {
      emit(SlotsLoaded(current.slots, selectedSlotId: slotId));
    }
  }

  Future<void> confirmBooking(int doctorId) async {
    if (selectedSlotId == null) return;
    emit(BookingInProgress());
    try {
      final isSuccess = await bookUseCase(doctorId, selectedSlotId!);
      
      if (isSuccess) {
        emit(BookingSuccess());
      } else {
        emit(BookAppointmentError('فشل تأكيد الحجز، الموعد قد يكون محجوزاً بالفعل'));
      }
    } catch (e) {
      emit(BookAppointmentError(e.toString()));
    }
  }
}