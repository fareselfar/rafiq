import 'package:rafiq/features/chatbot/domain/entities/message_entity.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatActive extends ChatState {
  final List<MessageEntity> messages;
  ChatActive(this.messages);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
