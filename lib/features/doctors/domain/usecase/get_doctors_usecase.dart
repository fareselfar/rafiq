import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

import '../../data/repositories/doctors_repository_impl.dart';

class GetDoctorsUseCase {
  final DoctorsRepository repository;
  GetDoctorsUseCase(this.repository);

  Future<List<DoctorEntity>> call({String? search}) =>
      repository.getDoctors(search: search);
}

class GetDoctorProfileUseCase {
  final DoctorsRepository repository;
  GetDoctorProfileUseCase(this.repository);

  Future<DoctorProfileEntity> call(int id) => repository.getDoctorProfile(id);
}