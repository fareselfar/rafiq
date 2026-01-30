import 'package:equatable/equatable.dart';

class ChatbotEntity extends Equatable {
  final String id;
  final String name;

  const ChatbotEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
