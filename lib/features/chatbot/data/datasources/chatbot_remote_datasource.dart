import '../models/chatbot_model.dart';

abstract class ChatbotRemoteDataSource {
  Future<List<ChatbotModel>> getChatbots();
  Future<ChatbotModel> getChatbotById(String id);
}

class ChatbotRemoteDataSourceImpl implements ChatbotRemoteDataSource {
  @override
  Future<List<ChatbotModel>> getChatbots() async {
    throw UnimplementedError();
  }

  @override
  Future<ChatbotModel> getChatbotById(String id) async {
    throw UnimplementedError();
  }
}
