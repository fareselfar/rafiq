import '../models/specialization_model.dart';

abstract class SpecializationRemoteDataSource {
  Future<List<SpecializationModel>> getSpecializations();
  Future<SpecializationModel> getSpecializationById(String id);
}

class SpecializationRemoteDataSourceImpl
    implements SpecializationRemoteDataSource {
  @override
  Future<List<SpecializationModel>> getSpecializations() async {
    throw UnimplementedError();
  }

  @override
  Future<SpecializationModel> getSpecializationById(String id) async {
    throw UnimplementedError();
  }
}
