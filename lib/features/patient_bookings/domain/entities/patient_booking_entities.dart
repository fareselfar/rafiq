class PatientAppointmentEntity {
  final int id;
  final String doctorName;
  final String specialization;
  final String? imagePath;
  final String appointmentDate;
  final String appointmentTime;
  final String location;
  final double price;
  final String status;

  const PatientAppointmentEntity({
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

  bool get isUpcoming => status == 'Pending' || status == 'Confirmed';
  bool get isCompleted => status == 'Completed';
  bool get isCancelled => status == 'Cancelled';
}

class AppointmentDetailsEntity {
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
  final double consultationPrice;
  final double discount;
  final double totalAmount;
  final String status;

  const AppointmentDetailsEntity({
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
    required this.consultationPrice,
    required this.discount,
    required this.totalAmount,
    required this.status,
  });

  bool get isUpcoming => status == 'Pending' || status == 'Confirmed';
}
