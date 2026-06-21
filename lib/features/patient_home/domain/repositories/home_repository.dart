import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_home/domain/entities/search_doctor_entity.dart';
import '../../../../core/errors/failure.dart';
import '../entities/home_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeEntity>>> getHomes();
  Future<Either<Failure, HomeEntity>> getHomeById(String id);
  Future<Either<Failures, List<SearchDoctorEntity>>> searchDoctors(
    String query,
  );
}
