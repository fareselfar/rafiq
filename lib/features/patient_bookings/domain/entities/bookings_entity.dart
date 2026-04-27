import 'package:equatable/equatable.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class BookingEntity extends Equatable {
  final String id;
  final DoctorsEntity doctor;
  final DateTime date;
  final String time;
  final double subTotal;
  final double discount;
  final BookingStatus status;

  const BookingEntity({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
    required this.subTotal,
    required this.discount,
    required this.status,
  });

  // السعر النهائي
  double get totalPrice => subTotal - discount;

  // بيانات الدكتور مباشرة
  String get doctorName => doctor.name;
  String get specialty => doctor.specialization;
  String get location => doctor.address;
  String get doctorImageUrl => doctor.imageUrl;
  double get doctorRating => doctor.rating;
  int get doctorReviewsCount => doctor.reviewCount;
  int get consultationPrice => doctor.consultationPrice;
  DoctorAvailability get doctorAvailability => doctor.availability;

  @override
  List<Object?> get props => [id, doctor, date, time, status];
}
