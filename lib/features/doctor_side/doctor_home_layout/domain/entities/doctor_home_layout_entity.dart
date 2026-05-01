import 'package:equatable/equatable.dart';

class DoctorHomeLayoutEntity extends Equatable {
  final String id;
  final String name;

  const DoctorHomeLayoutEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
