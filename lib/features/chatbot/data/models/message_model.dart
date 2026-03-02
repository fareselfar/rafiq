import 'package:rafiq/features/chatbot/domain/entities/message_entity.dart';

enum MessageSender { user, bot }

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.text,
    required super.sender,
    required super.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] ?? '',
      sender: json['sender'] ?? 'bot',
      time: DateTime.now(),
    );
  }
}
