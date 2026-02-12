import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/features/doctors/data/models/patient_review_model.dart';
import 'package:rafiq/features/doctors/data/models/working_hours_model.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class DoctorsModel extends DoctorsEntity {
  const DoctorsModel({
    required super.id,
    required super.name,
    required super.specialization,
    required super.rating,
    required super.reviewCount, 
    required super.address,
    required super.imageUrl,
    required super.availability,
    required super.consultationPrice, 
    required super.yearsOfExperience, 
    required super.patientCount,      
    required super.waitingTime,      
    required super.bio,                
    required super.workingHours,      
    required super.reviews,         
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      address: json['address'] ?? '',
      imageUrl: json['image_url'] ?? '',
      availability: _mapAvailability(json['availability']),
      consultationPrice: json['consultation_price'] ?? 0,
      yearsOfExperience: json['years_of_experience'] ?? 0,
      patientCount: json['patient_count'] ?? 0,
      waitingTime: json['waiting_time'] ?? 0,
      bio: json['bio'] ?? '',
      // تحويل القوائم
      workingHours: (json['working_hours'] as List?)
              ?.map((x) => WorkingHoursModel.fromJson(x))
              .toList() ?? [],
      reviews: (json['reviews'] as List?)
              ?.map((x) => PatientReviewModel.fromJson(x))
              .toList() ?? [],
    );
  }

  static DoctorAvailability _mapAvailability(dynamic value) {
    switch (value) {
      case 'available_now':
        return DoctorAvailability.availableNow;
      case 'available_tomorrow':
        return DoctorAvailability.availableTomorrow;
      case 'unavailable':
        return DoctorAvailability.unavailable;
      default:
        return DoctorAvailability.unavailable;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'rating': rating,
      'review_count': reviewCount,
      'address': address,
      'image_url': imageUrl,
      'availability': _availabilityToJson(),
      'consultation_price': consultationPrice,
      'years_of_experience': yearsOfExperience,
      'patient_count': patientCount,
      'waiting_time': waitingTime,
      'bio': bio,
    };
  }

  String _availabilityToJson() {
    switch (availability) {
      case DoctorAvailability.availableNow: return 'available_now';
      case DoctorAvailability.availableTomorrow: return 'available_tomorrow';
      case DoctorAvailability.unavailable: return 'unavailable';
    }
  }
}