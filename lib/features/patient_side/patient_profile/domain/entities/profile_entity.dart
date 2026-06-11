import 'package:equatable/equatable.dart';

class ArticlesEntity extends Equatable {
  final String id;
  final String name;

  const ArticlesEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
