// lib/features/doctor_side/doctor_home/domain/usecases/get_doctor_home_data_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import '../entities/doctor_home_entity.dart';
import '../repositories/doctor_home_repository.dart';

class GetDoctorHomeDataUsecase {
  final DoctorHomeRepository repository;

  GetDoctorHomeDataUsecase(this.repository);

  Future<Either<Failure, DoctorHomeEntity>> call() =>
      repository.getDoctorHomeData();
}