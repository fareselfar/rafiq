import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/ticket_entity.dart';

abstract class TicketRepository {
  Future<Either<Failure, List<TicketEntity>>> getTickets();
  Future<Either<Failure, TicketEntity>> getTicketById(String id);
}
