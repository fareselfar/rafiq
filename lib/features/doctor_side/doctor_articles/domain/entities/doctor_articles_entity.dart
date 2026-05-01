import 'package:equatable/equatable.dart';

class DoctorArticlesEntity extends Equatable {
  final String id;
  final String name;

  const DoctorArticlesEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
