part of 'chatbot_cubit.dart';

abstract class ChatbotState extends Equatable {
  const ChatbotState();

  @override
  List<Object> get props => [];
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial();
}

class ChatbotLoading extends ChatbotState {}

class ChatbotLoaded extends ChatbotState {}

class ChatbotError extends ChatbotState {
  final String message;
  const ChatbotError(this.message);

  @override
  List<Object> get props => [message];
}
