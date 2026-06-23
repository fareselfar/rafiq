import 'package:rafiq/features/specialization/data/models/specialization_model.dart';

abstract class SpecializationRemoteDataSource {
  Future<List<SpecializationResponse>> getSpecializations();
}