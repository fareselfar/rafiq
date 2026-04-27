import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.doctor,
    required super.date,
    required super.time,
    required super.subTotal,
    required super.discount,
    required super.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id']?.toString() ?? '',
      doctor: DoctorsModel.fromJson(json['doctor'] ?? {}),
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      time: json['time'] ?? '',
      subTotal: (json['sub_total'] as num?)?.toDouble() ?? 0.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      status: _mapStatusToEnum(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': (doctor as DoctorsModel).toJson(),
      'date': date.toIso8601String(),
      'time': time,
      'sub_total': subTotal,
      'discount': discount,
      'total_price': totalPrice,
      'status': status.name,
    };
  }

  static BookingStatus _mapStatusToEnum(String? status) {
    switch (status?.toLowerCase()) {
      case 'upcoming': return BookingStatus.upcoming;
      case 'completed': return BookingStatus.completed;
      case 'cancelled': return BookingStatus.cancelled;
      default: return BookingStatus.upcoming;
    }
  }
}