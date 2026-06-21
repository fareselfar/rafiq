import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

abstract class DoctorsRepository {
  Future<Either<Failure, List<DoctorEntity>>> getDoctors();
  Future<Either<Failure, DoctorEntity>> getDoctorDetails(
    int id,
  ); // الـ ID بقى int
}

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
