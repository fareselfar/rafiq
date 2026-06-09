import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/chatbot/data/repositories/chatbot_repository_impl.dart';
import 'package:rafiq/features/chatbot/domain/entities/message_entity.dart';
import 'chatbot_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  // نحتفظ بنسخة من الرسايل داخل الـ cubit
  final List<MessageEntity> _messages = [];

  // subscription للـ stream الحالي عشان نقدر نلغيه لو احتجنا
  StreamSubscription<dynamic>? _streamSub;

  // session id ثابت طول عمر الـ cubit (= طول عمر المحادثة)
  final String sessionId = DateTime.now().millisecondsSinceEpoch.toString();

  ChatCubit(this.repository) : super(const ChatInitial());

  /// هل المحادثة بدأت فعلاً
  bool get isChatStarted => _messages.isNotEmpty;

  /// هل الـ bot بيكتب دلوقتي
  bool get isTyping => state is ChatStreaming;

  // SEND MESSAGE
  void sendMessage(String text) {
    if (text.trim().isEmpty || isTyping) return;

    // 1. أضف رسالة المستخدم
    _messages.add(MessageEntity(
      text: text.trim(),
      sender: 'user',
      time: DateTime.now(),
    ));

    // 2. أضف placeholder فاضي للـ bot
    _messages.add(MessageEntity(
      text: '',
      sender: 'bot',
      time: DateTime.now(),
    ));

    emit(ChatStreaming(List.from(_messages)));

    _streamSub?.cancel();
    _streamSub = repository
        .getChatResponseStream(message: text.trim(), sessionId: sessionId)
        .listen(
      (either) {
        either.fold(
          (failure) {
            _replaceLastBotMessage('حدث خطأ: ${failure.message}');
            emit(ChatError(
              message: failure.message,
              messages: List.from(_messages),
            ));
          },
          (chunk) {
            _appendChunkToLastBotMessage(chunk);
            emit(ChatStreaming(List.from(_messages)));
          },
        );
      },
      onDone: () {
        if (!isClosed) emit(ChatActive(List.from(_messages)));
      },
      onError: (e) {
        _replaceLastBotMessage('حدث خطأ في الاتصال');
        if (!isClosed) {
          emit(ChatError(
            message: e.toString(),
            messages: List.from(_messages),
          ));
        }
      },
    );
  }

  // CLEAR CHAT
  void clearChat() {
    _streamSub?.cancel();
    _messages.clear();
    repository.disconnect();
    emit(const ChatInitial());
  }

  // وظائف مساعدة لتعديل آخر رسالة بوت بسهولة
  void _appendChunkToLastBotMessage(String chunk) {
    final idx = _messages.lastIndexWhere((m) => m.sender == 'bot');
    if (idx == -1) return;

    final old = _messages[idx];
    _messages[idx] = MessageEntity(
      text: old.text + chunk,
      sender: old.sender,
      time: old.time,
    );
  }

  void _replaceLastBotMessage(String text) {
    final idx = _messages.lastIndexWhere((m) => m.sender == 'bot');
    if (idx == -1) return;

    final old = _messages[idx];
    _messages[idx] = MessageEntity(
      text: text,
      sender: old.sender,
      time: old.time,
    );
  }

  @override
  Future<void> close() {
    _streamSub?.cancel();
    repository.disconnect();
    return super.close();
  }
}