import 'package:rafiq/features/doctors/data/models/profile_models.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

import '../datasources/doctors_remote_datasource.dart';
import '../models/doctor_list_model.dart';

// Abstract
abstract class DoctorsRepository {
  Future<List<DoctorEntity>> getDoctors({String? search});
  Future<DoctorProfileEntity> getDoctorProfile(int id);
}

// Impl — mapping هنا من Model → Entity
class DoctorsRepositoryImpl implements DoctorsRepository {
  final DoctorsRemoteDatasource datasource;
  DoctorsRepositoryImpl(this.datasource);

  @override
  Future<List<DoctorEntity>> getDoctors({String? search}) async {
    final models = await datasource.getDoctors(search: search);
    return models.map(_mapListModel).toList();
  }

  @override
  Future<DoctorProfileEntity> getDoctorProfile(int id) async {
    final model = await datasource.getDoctorProfile(id);
    return _mapProfileModel(model);
  }

  DoctorEntity _mapListModel(DoctorListModel m) => DoctorEntity(
        id: m.id,
        fullName: m.fullName,
        specialization: m.specialization,
        imagePath: m.imagePath,
        rate: m.rate,
        price: m.price,
        address: m.address,
        isAvailableToday: m.isAvailableToday,
      );

  DoctorProfileEntity _mapProfileModel(DoctorProfileModel m) =>
      DoctorProfileEntity(
        id: m.id,
        fullName: m.fullName,
        specialization: m.specialization,
        imagePath: m.imagePath,
        rate: m.rate,
        reviewsCount: m.reviewsCount,
        bio: m.bio,
        price: m.price,
        yearsOfExperience: m.yearsOfExperience,
        patientsCount: m.patientsCount,
        waitingTime: m.waitingTime,
        address: m.address,
        weeklySchedule: m.weeklySchedule
            .map((s) => WeeklyScheduleEntity(
                  dayName: s.dayName,
                  timeRange: s.timeRange,
                  isClosed: s.isClosed,
                ))
            .toList(),
      );
}