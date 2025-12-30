import 'package:equatable/equatable.dart';

class AuthenticationEntity extends Equatable {
  final String id;
  final String name;

  const AuthenticationEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
