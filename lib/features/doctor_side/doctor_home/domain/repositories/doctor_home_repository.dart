// lib/features/doctor_side/doctor_home/domain/repositories/doctor_home_repository.dart

import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../entities/doctor_home_entity.dart';

abstract class DoctorHomeRepository {
  Future<Either<Failure, DoctorHomeEntity>> getDoctorHomeData();
}
