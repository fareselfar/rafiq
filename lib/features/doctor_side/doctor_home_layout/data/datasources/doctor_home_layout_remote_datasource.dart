import '../models/doctor_home_layout_model.dart';

abstract class DoctorHomeLayoutRemoteDataSource {
  Future<List<DoctorHomeLayoutModel>> getDoctorHomeLayouts();
  Future<DoctorHomeLayoutModel> getDoctorHomeLayoutById(String id);
}

class DoctorHomeLayoutRemoteDataSourceImpl
    implements DoctorHomeLayoutRemoteDataSource {
  @override
  Future<List<DoctorHomeLayoutModel>> getDoctorHomeLayouts() async {
    throw UnimplementedError();
  }

  @override
  Future<DoctorHomeLayoutModel> getDoctorHomeLayoutById(String id) async {
    throw UnimplementedError();
  }
}
