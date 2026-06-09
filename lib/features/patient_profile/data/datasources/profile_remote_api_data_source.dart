import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/app_exception.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/patient_profile/data/datasources/profile_remote_data_source.dart';
import 'package:rafiq/features/patient_profile/data/models/profile_model.dart';
class ProfileRemoteApiDataSource implements ProfileRemoteDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final token = await AuthSharedPrefs().getToken();
      var response = await dio.get(
        AppConstants.getProfileEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      ProfileModel profile = ProfileModel.fromJson(response.data);
      return profile;
    } catch (exp) {
      print(exp);
      String? message;
      if (exp is DioException) {
        print("STATUS => ${exp.response?.statusCode}");
        print("DATA => ${exp.response?.data}");
        message = exp.response?.data["message"];
      }
      throw RemoteException(message: message ?? "Failed to fetch profile");
    }
  }
}
