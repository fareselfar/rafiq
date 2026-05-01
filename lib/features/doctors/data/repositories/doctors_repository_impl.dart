import 'package:dartz/dartz.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';
import '../datasources/doctors_remote_datasource.dart';
import '../../domain/repositories/doctors_repository.dart';

class DoctorsRepositoryImpl implements DoctorsRepository {
  final DoctorsRemoteDataSource remoteDataSource;
  DoctorsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorsModel>>> getDoctors() async {
    try {
      final remoteDoctors = await remoteDataSource.getDoctors();
      return Right(remoteDoctors);
    } catch (e) {
      return const Left(ServerFailure('حدث خطأ أثناء تحميل البيانات'));
    }
  }

  @override
  Future<Either<Failure, DoctorsModel>> getDoctorDetails(int id) async {
    throw UnimplementedError();
  }
}
