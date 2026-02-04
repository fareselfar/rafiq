import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/chatbot_entity.dart';
import '../../domain/repositories/chatbot_repository.dart';
import '../datasources/chatbot_remote_datasource.dart';

class ChatbotRepositoryImpl implements ChatbotRepository {
  final ChatbotRemoteDataSource remoteDataSource;

  ChatbotRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ChatbotEntity>>> getChatbots() async {
    try {
      final result = await remoteDataSource.getChatbots();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ChatbotEntity>> getChatbotById(String id) async {
    try {
      final result = await remoteDataSource.getChatbotById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
