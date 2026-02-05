import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<MessageModel> getChatResponse(String message);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<MessageModel> getChatResponse(String message) async {
    // هنا مستقبلاً هتستخدم Dio لطلب الـ API
    await Future.delayed(const Duration(seconds: 2)); 
    return MessageModel(text: "رد تجريبي من الـ AI", sender: "bot", time: DateTime.now());
  }
}
