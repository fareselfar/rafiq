import '../../domain/entities/doctors_entity.dart';

class DoctorsModel extends DoctorsEntity {
  const DoctorsModel({required super.id, required super.name});

  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
