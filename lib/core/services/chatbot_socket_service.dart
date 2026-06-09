import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

enum SocketEventType { chunk, done, ping, error }

class SocketEvent {
  final SocketEventType type;
  final String? content;
  final String? sessionId;
  final String? error;

  const SocketEvent({
    required this.type,
    this.content,
    this.sessionId,
    this.error,
  });
}

class ChatSocketService {
  WebSocketChannel? _channel;
  StreamController<SocketEvent>? _controller;

  Stream<SocketEvent> connect(String wsUrl) {
    _controller = StreamController<SocketEvent>.broadcast();

    try {
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _channel!.stream.listen(
        (raw) {
          try {
            final data = jsonDecode(raw as String) as Map<String, dynamic>;
            final type = data['type'] as String?;

            switch (type) {
              case 'chunk':
                _controller?.add(SocketEvent(
                  type: SocketEventType.chunk,
                  content: data['content'] as String? ?? '',
                  sessionId: data['session_id'] as String?,
                ));
              case 'done':
                _controller?.add(SocketEvent(
                  type: SocketEventType.done,
                  sessionId: data['session_id'] as String?,
                ));
              case 'ping':
                // الـ server بيبعت ping كل 30 ثانية — نرد بـ pong
                _send({'type': 'pong'});
              case 'error':
                _controller?.add(SocketEvent(
                  type: SocketEventType.error,
                  error: data['error'] as String? ?? 'خطأ غير معروف',
                ));
            }
          } catch (_) {
            _controller?.add(const SocketEvent(
              type: SocketEventType.error,
              error: 'فشل في تحليل الرسالة',
            ));
          }
        },
        onError: (e) {
          _controller?.add(SocketEvent(
            type: SocketEventType.error,
            error: e.toString(),
          ));
        },
        onDone: () => _controller?.close(),
      );
    } catch (e) {
      _controller?.add(SocketEvent(
        type: SocketEventType.error,
        error: 'فشل الاتصال: ${e.toString()}',
      ));
    }

    return _controller!.stream;
  }

  /// بيبعت السؤال للـ server — الـ server بيتوقع:
  /// { "question": "...", "session_id": "..." }
  void sendQuestion({required String question, required String sessionId}) {
    _send({'question': question, 'session_id': sessionId});
  }

  void _send(Map<String, dynamic> data) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode(data));
    }
  }

  void disconnect() {
    _channel?.sink.close(status.goingAway);
    _controller?.close();
    _channel = null;
    _controller = null;
  }
}