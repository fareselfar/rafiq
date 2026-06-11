import '../models/home_layout_model.dart';

abstract class HomeLayoutRemoteDataSource {
  Future<List<HomeLayoutModel>> getHomeLayouts();
  Future<HomeLayoutModel> getHomeLayoutById(String id);
}

class HomeLayoutRemoteDataSourceImpl implements HomeLayoutRemoteDataSource {
  @override
  Future<List<HomeLayoutModel>> getHomeLayouts() async {
    throw UnimplementedError();
  }

  @override
  Future<HomeLayoutModel> getHomeLayoutById(String id) async {
    throw UnimplementedError();
  }
}
