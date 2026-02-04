import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/chatbot_entity.dart';

abstract class ChatbotRepository {
  Future<Either<Failure, List<ChatbotEntity>>> getChatbots();
  Future<Either<Failure, ChatbotEntity>> getChatbotById(String id);
}
