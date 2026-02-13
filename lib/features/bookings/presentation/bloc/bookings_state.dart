// presentation/cubit/bookings_state.dart
import 'package:equatable/equatable.dart';
import 'package:rafiq/features/bookings/domain/entities/bookings_entity.dart';

abstract class BookingsState extends Equatable {
  const BookingsState();
  @override
  List<Object?> get props => [];
}

class BookingsInitial extends BookingsState {}

// حالة التحميل
class BookingsLoading extends BookingsState {}

// حالة النجاح في جلب البيانات
class BookingsSuccess extends BookingsState {
  final List<BookingEntity> bookings;
  const BookingsSuccess(this.bookings);
  @override
  List<Object?> get props => [bookings];
}

// حالة الفشل (سواء جلب بيانات أو أكشن)
class BookingsFailure extends BookingsState {
  final String errorMessage;
  const BookingsFailure(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

// حالة نجاح إلغاء الحجز (عشان تظهر الـ Success Dialog)
class BookingCancelSuccess extends BookingsState {}

// حالة نجاح تعديل الموعد
class BookingRescheduleSuccess extends BookingsState {}

