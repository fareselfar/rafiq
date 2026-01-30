import 'package:equatable/equatable.dart';

class TicketEntity extends Equatable {
  final String id;
  final String name;

  const TicketEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
