import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failuree.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_response.dart';
import 'package:rafiq/features/patient_profile/domain/entities/ProfileEntity.dart';

abstract class ProfileRepository {
  Future<Either<Failures, ProfileEntity>> getProfile();
  Future<Either<Failures, ChangePassResponse>> changePass(
    ChangePassRequest request,
  );
}
