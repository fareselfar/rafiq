import 'package:equatable/equatable.dart';
import '../../domain/entities/message_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatStreaming extends ChatState {
  final List<MessageEntity> messages;
  const ChatStreaming(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatActive extends ChatState {
  final List<MessageEntity> messages;
  const ChatActive(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  final String message;
  final List<MessageEntity> messages; 
  const ChatError({required this.message, required this.messages});

  @override
  List<Object?> get props => [message, messages];
}