import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/doctor_appointments_entity.dart';
import '../../domain/repositories/doctor_appointments_repository.dart';
import '../datasources/doctor_appointments_remote_datasource.dart';

class DoctorAppointmentsRepositoryImpl implements DoctorAppointmentsRepository {
  final DoctorAppointmentsRemoteDataSource remoteDataSource;

  DoctorAppointmentsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorAppointmentsEntity>>>
  getDoctorAppointmentss() async {
    try {
      final result = await remoteDataSource.getDoctorAppointmentss();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, DoctorAppointmentsEntity>> getDoctorAppointmentsById(
    String id,
  ) async {
    try {
      final result = await remoteDataSource.getDoctorAppointmentsById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
