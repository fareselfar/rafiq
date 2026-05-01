import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/doctor_home_layout_entity.dart';

abstract class DoctorHomeLayoutRepository {
  Future<Either<Failure, List<DoctorHomeLayoutEntity>>> getDoctorHomeLayouts();
  Future<Either<Failure, DoctorHomeLayoutEntity>> getDoctorHomeLayoutById(
    String id,
  );
}
