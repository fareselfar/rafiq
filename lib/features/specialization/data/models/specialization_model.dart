import 'package:rafiq/features/specialization/domain/entities/specialization_entity.dart';

class SpecializationResponse extends SpecializationEntity {
  const SpecializationResponse({
    required super.id,
    required super.name,
    required super.iconUrl,
    required super.doctorsCount,
  });

  factory SpecializationResponse.fromJson(Map<String, dynamic> json) {
    return SpecializationResponse(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      iconUrl: json['iconUrl'] ?? '',
      doctorsCount: json['doctorsCount'] ?? 0,
    );
  }
}