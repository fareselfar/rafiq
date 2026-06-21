import 'package:dio/dio.dart';
import 'package:rafiq/features/doctors/data/models/profile_models.dart';
import '../models/doctor_list_model.dart';

abstract class DoctorsRemoteDatasource {
  Future<List<DoctorListModel>> getDoctors({String? search});
  Future<DoctorProfileModel> getDoctorProfile(int id);
}

class DoctorsRemoteDatasourceImpl implements DoctorsRemoteDatasource {
  final Dio dio;
  DoctorsRemoteDatasourceImpl(this.dio);

  @override
  Future<List<DoctorListModel>> getDoctors({String? search}) async {
    final response = await dio.get(
      '/Doctors/allDoctors',
      queryParameters: search != null ? {'search': search} : null,
    );
    return (response.data as List)
        .map((e) => DoctorListModel.fromJson(e))
        .toList();
  }

  @override
  Future<DoctorProfileModel> getDoctorProfile(int id) async {
    final response = await dio.get('/Doctors/$id/details');
    return DoctorProfileModel.fromJson(response.data);
  }
}