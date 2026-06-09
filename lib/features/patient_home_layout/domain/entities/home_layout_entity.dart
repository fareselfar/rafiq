import 'package:equatable/equatable.dart';

class HomeLayoutEntity extends Equatable {
  final String id;
  final String name;

  const HomeLayoutEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
