import '../models/doctor_articles_model.dart';

abstract class DoctorArticlesRemoteDataSource {
  Future<List<DoctorArticlesModel>> getDoctorArticless();
  Future<DoctorArticlesModel> getDoctorArticlesById(String id);
}

class DoctorArticlesRemoteDataSourceImpl
    implements DoctorArticlesRemoteDataSource {
  @override
  Future<List<DoctorArticlesModel>> getDoctorArticless() async {
    throw UnimplementedError();
  }

  @override
  Future<DoctorArticlesModel> getDoctorArticlesById(String id) async {
    throw UnimplementedError();
  }
}
