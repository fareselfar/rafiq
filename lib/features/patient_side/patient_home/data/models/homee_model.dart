import '../../domain/entities/homee_entity.dart';

class HomeeModel extends HomeeEntity {
  const HomeeModel({required super.id, required super.name});

  factory HomeeModel.fromJson(Map<String, dynamic> json) {
    return HomeeModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
