import '../../domain/entities/specialization_entity.dart';

class SpecializationModel extends SpecializationEntity {
  const SpecializationModel({required super.id, required super.name});

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
