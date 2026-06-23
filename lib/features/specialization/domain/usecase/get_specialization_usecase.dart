import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/specialization/domain/entities/specialization_entity.dart';
import 'package:rafiq/features/specialization/domain/repositories/specialization_repository.dart';

class GetSpecializationsUseCase {
  final SpecializationRepository repository;

  GetSpecializationsUseCase({required this.repository});

  Future<Either<Failures, List<SpecializationEntity>>> call() async {
    return await repository.getSpecializations();
  }
}
