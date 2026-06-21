import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/patient_home/data/models/search_doctor_model.dart';

import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeModel>> getHomes();
  Future<HomeModel> getHomeById(String id);
  Future<List<SearchDoctorModel>> searchDoctors(String query);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
  @override
  Future<List<HomeModel>> getHomes() async {
    throw UnimplementedError();
  }

  @override
  Future<HomeModel> getHomeById(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<SearchDoctorModel>> searchDoctors(String query) async {
    try {
      final response = await dio.get(
        AppConstants.getDoctorEndpoint,
        queryParameters: {'query': query},
      );

      return (response.data as List)
          .map((e) => SearchDoctorModel.fromJson(e))
          .toList();
    } catch (exp) {
      print(exp);
      String? message;
      if (exp is DioException) {
        print("STATUS => ${exp.response?.statusCode}");
        print("DATA => ${exp.response?.data}");
        message = exp.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to change password");
    }
  }
}
