import 'package:dartz/dartz.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import '../repositories/doctors_repository.dart';

class GetDoctorsUseCase {
  final DoctorsRepository repository;
  GetDoctorsUseCase(this.repository);

  Future<Either<Failure, List<DoctorsEntity>>> call() async {
    return await repository.getDoctors();
  }
}
