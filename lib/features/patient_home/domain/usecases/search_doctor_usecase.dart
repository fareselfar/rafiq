import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_home/domain/entities/search_doctor_entity.dart';
import 'package:rafiq/features/patient_home/domain/repositories/home_repository.dart';

class SearchDoctorsUseCase {
  final HomeRepository repository;

  SearchDoctorsUseCase({required this.repository});

  Future<Either<Failures, List<SearchDoctorEntity>>> call({
    required String query,
  }) {
    return repository.searchDoctors(query);
  }
}
