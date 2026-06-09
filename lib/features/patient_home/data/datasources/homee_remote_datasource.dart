import '../models/homee_model.dart';

abstract class HomeeRemoteDataSource {
  Future<List<HomeeModel>> getHomees();
  Future<HomeeModel> getHomeeById(String id);
}

class HomeeRemoteDataSourceImpl implements HomeeRemoteDataSource {
  @override
  Future<List<HomeeModel>> getHomees() async {
    throw UnimplementedError();
  }

  @override
  Future<HomeeModel> getHomeeById(String id) async {
    throw UnimplementedError();
  }
}
