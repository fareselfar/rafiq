import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../datasources/chatbot_remote_datasource.dart';

abstract class ChatRepository {
  Stream<Either<Failure, String>> getChatResponseStream({
    required String message,
    required String sessionId,
  });

  void disconnect();
}

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, String>> getChatResponseStream({
    required String message,
    required String sessionId,
  }) async* {
    try {
      final stream = remoteDataSource.getChatResponseStream(
        message: message,
        sessionId: sessionId,
      );

      await for (final chunk in stream) {
        yield Right(chunk);
      }
    } catch (e) {
      yield Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  void disconnect() => remoteDataSource.disconnect();
}