import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/message_entity.dart';
import '../datasources/chatbot_remote_datasource.dart';

abstract class ChatRepository {
  Future<Either<Failure, MessageEntity>> getChatResponse(String message);
}

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, MessageEntity>> getChatResponse(String message) async {
    try {
      final result = await remoteDataSource.getChatResponse(message);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "خطأ غير متوقع"));
    }
  }
}
