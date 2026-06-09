import 'package:rafiq/features/chatbot/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.text,
    required super.sender,
    required super.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['messageText'] ?? json['text'] ?? '', 
      sender: json['sender'] ?? 'bot',
      time: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'messageText': text,
      'createdAt': time.toIso8601String(),
    };
  }
}