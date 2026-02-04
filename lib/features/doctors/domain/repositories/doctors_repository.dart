import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/doctors_entity.dart';

abstract class DoctorsRepository {
  Future<Either<Failure, List<DoctorsEntity>>> getDoctorss();
  Future<Either<Failure, DoctorsEntity>> getDoctorsById(String id);
}
