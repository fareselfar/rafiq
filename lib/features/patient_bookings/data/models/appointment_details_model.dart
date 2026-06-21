// GET /api/Appointments/details/:appointmentId
// Response: AppointmentForPatientDetailsDto

class AppointmentDetailsModel {
  final int id;
  final String doctorName;
  final String specialization;
  final String? imagePath;
  final double rate;
  final int reviewsCount;
  final String dayName;
  final String date;
  final String time;
  final String location;
  final double? consultationPrice;
  final double? discount;
  final double? totalAmount;
  final String status;

  const AppointmentDetailsModel({
    required this.id,
    required this.doctorName,
    required this.specialization,
    this.imagePath,
    required this.rate,
    required this.reviewsCount,
    required this.dayName,
    required this.date,
    required this.time,
    required this.location,
    this.consultationPrice,
    this.discount,
    this.totalAmount,
    required this.status,
  });

  factory AppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailsModel(
      id: json['id'] ?? 0,
      doctorName: json['doctorName'] ?? '',
      specialization: json['specialization'] ?? '',
      imagePath: (() {
        final p = json['imagePath'] as String?;
        if (p == null) return null;
        if (p == 'http://rafiqapp.runasp.net' || p.isEmpty) return null;
        return p;
      })(),
      rate: (json['rate'] as num?)?.toDouble() ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
      dayName: json['dayName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      consultationPrice: (json['consultationPrice'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      status: json['status'] ?? 'Pending',
    );
  }
}
