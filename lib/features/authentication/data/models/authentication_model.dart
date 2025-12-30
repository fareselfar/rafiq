import '../../domain/entities/authentication_entity.dart';

class AuthenticationModel extends AuthenticationEntity {
  const AuthenticationModel({required super.id, required super.name});

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
