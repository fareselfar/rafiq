import '../models/edit_profile_model.dart';

abstract class EditProfileRemoteDataSource {
  Future<List<EditProfileModel>> getEditProfiles();
  Future<EditProfileModel> getEditProfileById(String id);
}

class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  @override
  Future<List<EditProfileModel>> getEditProfiles() async {
    throw UnimplementedError();
  }

  @override
  Future<EditProfileModel> getEditProfileById(String id) async {
    throw UnimplementedError();
  }
}
