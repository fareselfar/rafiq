import 'package:equatable/equatable.dart';

class EditProfileEntity extends Equatable {
  final String id;
  final String name;

  const EditProfileEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
