// lib/core/di/injection_container.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rafiq/core/utils/constants.dart';

import '../network/network_info.dart';
import '../api/api_interceptors.dart';

// ── Doctor Home ──

final sl = GetIt.instance;

Future<void> init() async {
  // ── External ──────────────────────────────────────────────
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.connectionTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // الترتيب مهم: Token الأول ثم Logger
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(ApiInterceptor());

    return dio;
  });

  // ── Doctor Home ───────────────────────────────────────────
  //   sl.registerFactory<DoctorHomeRemoteDataSource>(
  //     () => DoctorHomeRemoteDataSourceImpl(dio: sl()),
  //   );

  //   sl.registerFactory<DoctorHomeRepository>(
  //     () => DoctorHomeRepositoryImpl(remoteDataSource: sl()),
  //   );

  //   sl.registerFactory(() => GetDoctorHomeDataUsecase(sl()));

  //   sl.registerFactory(
  //     () => DoctorHomeCubit(getDoctorHomeData: sl()),
  //   );
  // }
}
