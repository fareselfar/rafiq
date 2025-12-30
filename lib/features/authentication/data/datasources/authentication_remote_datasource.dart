import '../models/authentication_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<List<AuthenticationModel>> getAuthentications();
  Future<AuthenticationModel> getAuthenticationById(String id);
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  @override
  Future<List<AuthenticationModel>> getAuthentications() async {
    throw UnimplementedError();
  }

  @override
  Future<AuthenticationModel> getAuthenticationById(String id) async {
    throw UnimplementedError();
  }
}
