import 'package:rafiq/features/patient_side/patient_profile/domain/entities/ProfileEntity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.fullName,
    required super.age,
    required super.appointmentsCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] ?? '',
      age: json['age'] ?? 0,
      appointmentsCount: json['appointmentsCount'] ?? 0,
    );
  }
}
