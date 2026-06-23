import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';

class DoctorProfileModel extends DoctorProfileEntity {
  const DoctorProfileModel({
    required super.fullName,
    required super.age,
    required super.gender,
    required super.imagePath,
    required super.appointmentsCount,
  });

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      fullName: json['fullName'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      imagePath: json['imagePath'],
      appointmentsCount: json['appointmentsCount'] ?? 0,
    );
  }
}
