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
      final response = await dio.get(AppConstants.getSpecializationsEndpoint);

      return (response.data as List)
          .map((e) => SpecializationResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw RemoteException(
        message:
            e.response?.data['message'] ?? 'Failed to load specializations',
      );
    }
  }
}
