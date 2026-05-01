import '../../domain/entities/doctor_home_layout_entity.dart';

class DoctorHomeLayoutModel extends DoctorHomeLayoutEntity {
  const DoctorHomeLayoutModel({required super.id, required super.name});

  factory DoctorHomeLayoutModel.fromJson(Map<String, dynamic> json) {
    return DoctorHomeLayoutModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
