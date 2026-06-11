import '../../domain/entities/edit_profile_entity.dart';

class EditProfileModel extends EditProfileEntity {
  const EditProfileModel({required super.id, required super.name});

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
