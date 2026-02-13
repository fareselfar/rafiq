import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class PaymentArguments {
  final DoctorsEntity doctor;
  final DateTime date;
  final String time;

  PaymentArguments({
    required this.doctor,
    required this.date,
    required this.time,
  });
}