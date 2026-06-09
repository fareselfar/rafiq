import 'package:equatable/equatable.dart';
import 'package:rafiq/core/enums/doctor_availability.dart';
import 'patient_review.dart';
import 'working_hours.dart';

class DoctorsEntity extends Equatable {
  final int id;
  final String name;
  final String specialization;
  final double rating;
  final int reviewCount;
  final String address;
  final String imageUrl;
  final DoctorAvailability availability;
  final int consultationPrice;
  final int yearsOfExperience;
  final int patientCount;
  final int waitingTime;
  final String bio;
  final List<WorkingHours> workingHours;
  final List<PatientReview> reviews;

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
