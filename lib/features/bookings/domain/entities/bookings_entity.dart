import 'package:equatable/equatable.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart'; // الربط هنا

class BookingEntity extends Equatable {
  final String id;
  final DoctorsEntity doctor; // استخدام الـ Entity الشاملة لصاحبك
  final DateTime date;
  final String time; 
  final double subTotal; 
  final double discount; 
  final double totalPrice; 
  final BookingStatus status;

  const BookingEntity({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
    required this.subTotal,
    required this.discount,
    required this.totalPrice,
    required this.status,
  });

  // Getters للسهولة في الـ UI
  String get doctorName => doctor.name;
  String get specialty => doctor.specialization;
  String get location => doctor.address;

  @override
  List<Object?> get props => [id, doctor, date, time, status];
}