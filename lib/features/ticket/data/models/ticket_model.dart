import '../../domain/entities/ticket_entity.dart';

class TicketModel extends TicketEntity {
  const TicketModel({required super.id, required super.name});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
