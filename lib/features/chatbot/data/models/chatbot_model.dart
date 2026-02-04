import '../../domain/entities/chatbot_entity.dart';

class ChatbotModel extends ChatbotEntity {
  const ChatbotModel({required super.id, required super.name});

  factory ChatbotModel.fromJson(Map<String, dynamic> json) {
    return ChatbotModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
