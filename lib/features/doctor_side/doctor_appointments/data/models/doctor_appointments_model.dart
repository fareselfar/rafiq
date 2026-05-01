import '../../domain/entities/doctor_appointments_entity.dart';

class DoctorAppointmentsModel extends DoctorAppointmentsEntity {
  const DoctorAppointmentsModel({required super.id, required super.name});

  factory DoctorAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return DoctorAppointmentsModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
