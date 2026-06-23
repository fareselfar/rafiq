import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/specialization/data/datasources/specialization_remote_datasource.dart';
import 'package:rafiq/features/specialization/data/models/specialization_model.dart';

class SpecializationRemoteDataSourceImpl
    implements SpecializationRemoteDataSource {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  SpecializationRemoteDataSourceImpl();

  @override
  Future<List<SpecializationResponse>> getSpecializations() async {
    try {
      print("API CALL START");
      final token = await AuthSharedPrefs().getToken();
      final response = await dio.get(
        AppConstants.getSpecializationsEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print("API RESPONSE:");
      print(response.data);
      print(response.data.runtimeType);

      return (response.data as List)
          .map((e) => SpecializationResponse.fromJson(e))
          .toList();
    } catch (e, s) {
      print("SPECIALIZATION ERROR => $e");
      print(s);
      rethrow;
    }
  }
}