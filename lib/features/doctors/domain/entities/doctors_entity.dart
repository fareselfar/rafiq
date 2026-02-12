import 'package:equatable/equatable.dart';
import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/features/doctors/domain/entities/patient_review.dart';
import 'package:rafiq/features/doctors/domain/entities/working_hours.dart';

class DoctorsEntity extends Equatable {
  final int id;
  final String name;
  final String specialization;
  final double rating;
  final int reviewCount;
  final String address;
  final String imageUrl;
  final DoctorAvailability availability;

  final int consultationPrice; // سعر الكشف
  final int yearsOfExperience; // سنوات الخبرة
  final int patientCount; // عدد المرضى (+500)
  final int waitingTime; // مدة الانتظار (بالدقائق)
  final String bio; // نبذة عن الطبيب
  final List<WorkingHours> workingHours; // مواعيد العمل
  final List<PatientReview> reviews; // آراء المرضى

  const DoctorsEntity({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.imageUrl,
    required this.availability,
    required this.consultationPrice,
    required this.yearsOfExperience,
    required this.patientCount,
    required this.waitingTime,
    required this.bio,
    required this.workingHours,
    required this.reviews,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    specialization,
    rating,
    reviewCount,
    address,
    imageUrl,
    availability,
    consultationPrice,
    yearsOfExperience,
    patientCount,
    waitingTime,
    bio,
    workingHours,
    reviews,
  ];
}
