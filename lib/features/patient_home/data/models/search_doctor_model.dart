import 'package:rafiq/features/patient_home/domain/entities/search_doctor_entity.dart';

class SearchDoctorModel extends SearchDoctorEntity {
  const SearchDoctorModel({
    required super.id,
    required super.name,
    super.specialization,
    super.address,
    required super.imagePath,
    required super.rate,
  });

  factory SearchDoctorModel.fromJson(Map<String, dynamic> json) {
    return SearchDoctorModel(
      id: json['id'],
      name: json['name'] ?? '',
      specialization: json['specialization'],
      address: json['address'],
      imagePath: json['imagePath'] ?? '',
      rate: (json['rate'] ?? 0).toDouble(),
    );
  }
}
