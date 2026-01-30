import 'package:equatable/equatable.dart';

class HomeeEntity extends Equatable {
  final String id;
  final String name;

  const HomeeEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
