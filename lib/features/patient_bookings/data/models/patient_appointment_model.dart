// features/patient_bookings/data/models/patient_appointment_model.dart
class PatientAppointmentModel {
  final int id;
  final String doctorName;
  final String specialization;
  final String? imagePath;
  final String appointmentDate;
  final String appointmentTime;
  final String location;
  final double price;
  final String status;

  const PatientAppointmentModel({
    required this.id,
    required this.doctorName,
    required this.specialization,
    this.imagePath,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.location,
    required this.price,
    required this.status,
  });

  factory PatientAppointmentModel.fromJson(Map<String, dynamic> json) {
    return PatientAppointmentModel(
      id: json['id'] ?? 0,
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
      imagePath: json['imagePath'],
      appointmentDate: json['appointmentDate'] ?? '',
      appointmentTime: json['appointmentTime'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      status: json['status'] ?? 'Pending',
    );
  }
}