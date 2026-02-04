// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/failure.dart';
// import '../../../../core/errors/exceptions.dart';
// import '../../domain/entities/doctors_entity.dart';
// import '../../domain/repositories/doctors_repository.dart';
// import '../datasources/doctors_remote_datasource.dart';

// class DoctorsRepositoryImpl implements DoctorsRepository {
//   final DoctorsRemoteDataSource remoteDataSource;

//   DoctorsRepositoryImpl({required this.remoteDataSource});

//   @override
//   Future<Either<Failure, List<DoctorsEntity>>> getDoctorss() async {
//     try {
//       final result = await remoteDataSource.getDoctorss();
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     } on NetworkException catch (e) {
//       return Left(NetworkFailure(message: e.message));
//     }
//   }

//   @override
//   Future<Either<Failure, DoctorsEntity>> getDoctorsById(String id) async {
//     try {
//       final result = await remoteDataSource.getDoctorsById(id);
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     } on NetworkException catch (e) {
//       return Left(NetworkFailure(message: e.message));
//     }
//   }
// }
