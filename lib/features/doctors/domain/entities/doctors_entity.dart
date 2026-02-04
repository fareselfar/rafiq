import 'package:equatable/equatable.dart';

class DoctorsEntity extends Equatable {
  final String id;
  final String name;

  const DoctorsEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
