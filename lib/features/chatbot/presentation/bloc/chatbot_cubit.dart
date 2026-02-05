import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/chatbot/data/repositories/chatbot_repository_impl.dart';
import 'package:rafiq/features/chatbot/presentation/bloc/chatbot_state.dart';
import '../../domain/entities/message_entity.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  ChatCubit(this.repository) : super(ChatInitial());

  List<MessageEntity> messages = [];

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = MessageEntity(text: text, sender: 'user', time: DateTime.now());
    messages.add(userMsg);
    emit(ChatActive(List.from(messages)));

    emit(ChatLoading()); 

    final result = await repository.getChatResponse(text);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (botMsg) {
        messages.add(botMsg);
        emit(ChatActive(List.from(messages)));
      },
    );
  }
}
