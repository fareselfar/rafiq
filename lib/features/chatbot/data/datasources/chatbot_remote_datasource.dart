import 'dart:async';
import '../../../../core/services/chatbot_socket_service.dart';

abstract class ChatRemoteDataSource {
  /// يرجع Stream من الـ chunks عشان نعمل streaming في الـ UI
  Stream<String> getChatResponseStream({
    required String message,
    required String sessionId,
  });

  void disconnect();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ChatSocketService socketService;
  final String wsUrl; // هتجيب دي من env أو constants

  ChatRemoteDataSourceImpl({
    required this.socketService,
    required this.wsUrl,
  });

  @override
  Stream<String> getChatResponseStream({
    required String message,
    required String sessionId,
  }) {
    // StreamController بيجمع الـ chunks ويرجعها للـ repo
    final chunkController = StreamController<String>();

    final socketStream = socketService.connect(wsUrl);

    // ابعت السؤال بعد ما الكونكشن يفتح - نستنى frame واحدة
    Future.microtask(() {
      socketService.sendQuestion(
        question: message,
        sessionId: sessionId,
      );
    });

    socketStream.listen(
      (event) {
        switch (event.type) {
          case SocketEventType.chunk:
            if (event.content != null && !chunkController.isClosed) {
              chunkController.add(event.content!);
            }
          case SocketEventType.done:
            chunkController.close();
          case SocketEventType.error:
            chunkController.addError(event.error ?? 'خطأ في الاتصال');
            chunkController.close();
          case SocketEventType.ping:
            break; // الـ service بترد تلقائياً
        }
      },
      onError: (e) {
        if (!chunkController.isClosed) {
          chunkController.addError(e);
          chunkController.close();
        }
      },
      onDone: () {
        if (!chunkController.isClosed) chunkController.close();
      },
    );

    return chunkController.stream;
  }

  @override
  void disconnect() => socketService.disconnect();
}