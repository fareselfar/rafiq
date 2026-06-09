import '../../domain/entities/doctor_articles_entity.dart';

class DoctorArticlesModel extends DoctorArticlesEntity {
  const DoctorArticlesModel({required super.id, required super.name});

  factory DoctorArticlesModel.fromJson(Map<String, dynamic> json) {
    return DoctorArticlesModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
