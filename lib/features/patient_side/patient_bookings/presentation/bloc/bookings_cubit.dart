// presentation/cubit/bookings_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/patient_side/patient_bookings/data/repositories/mock_bookings_repository.dart';
import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';
import 'bookings_state.dart';
import '../../domain/usecases/get_bookings_usecase.dart';
import '../../domain/usecases/cancel_booking_usecase.dart';
import '../../domain/usecases/reschedule_booking_usecase.dart';

class BookingsCubit extends Cubit<BookingsState> {
  final GetBookingsUseCase getBookingsUseCase;
  final CancelBookingUseCase cancelBookingUseCase;
  final RescheduleBookingUseCase rescheduleBookingUseCase;

  BookingsCubit({
    required this.getBookingsUseCase,
    required this.cancelBookingUseCase,
    required this.rescheduleBookingUseCase,
  }) : super(BookingsInitial());

  Future<void> fetchMyBookings() async {
    emit(BookingsLoading());
    final bookings = await MockBookingsRepository().getBookings();
    emit(BookingsSuccess(bookings as List<BookingEntity>));
  }

  Future<void> cancelMyBooking(String id) async {
    final result = await cancelBookingUseCase.call(id);

    result.fold((failure) => emit(BookingsFailure(failure)), (_) {
      emit(BookingCancelSuccess());
      fetchMyBookings();
    });
  }

  // 3. إعادة جدولة حجز
  Future<void> rescheduleMyBooking(RescheduleParams params) async {
    emit(BookingsLoading());
    final result = await rescheduleBookingUseCase.call(params);

    result.fold(
      (failure) => emit(BookingsFailure(failure)),
      (_) => emit(BookingRescheduleSuccess()),
    );
  }
}
