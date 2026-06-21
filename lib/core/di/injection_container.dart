// lib/core/di/injection_container.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/data/datasources/doctor_appointments_datasource.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/data/repositories/doctor_appointment_repository_impl.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/domain/repositories/doctor_appointments_repository.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/domain/usecases/doctor_appointments_usecases.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/bloc/doctor_appointments_cubit.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/data/datasources/doctor_article_remote_datasource.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/data/repositories/doctor_article_repository_impl.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/domain/repositories/doctor_article_repository.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/domain/usecases/add_article_usecase.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/domain/usecases/delete_article_usecase.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/domain/usecases/get_my_articles_usecase.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_cubit.dart';
import 'package:rafiq/features/doctors/data/datasources/doctors_remote_datasource.dart';
import 'package:rafiq/features/doctors/data/repositories/doctors_repository_impl.dart';
import 'package:rafiq/features/doctors/domain/usecase/get_doctors_usecase.dart';
import 'package:rafiq/features/doctors/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctors/presentation/bloc/doctors_cubit.dart';
import 'package:rafiq/features/patient_bookings/data/datasources/bookings_remote_datasource.dart';
import 'package:rafiq/features/patient_bookings/data/datasources/patient_bookings_datasource.dart';
import 'package:rafiq/features/patient_bookings/data/repositories/bookings_repository_impl.dart';
import 'package:rafiq/features/patient_bookings/data/repositories/patient_bookings_repository_impl.dart';
import 'package:rafiq/features/patient_bookings/domain/repositories/bookings_repository.dart';
import 'package:rafiq/features/patient_bookings/domain/repositories/patient_bookings_repository.dart';
import 'package:rafiq/features/patient_bookings/domain/usecases/booking_usecases.dart';
import 'package:rafiq/features/patient_bookings/domain/usecases/booking_usecases.dart'
    as booking_uc;
import 'package:rafiq/features/patient_bookings/domain/usecases/patient_bookings_usecases.dart'
    as patient_uc;
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/book_appointment_cubit.dart';
import '../network/network_info.dart';
import '../api/api_interceptors.dart';

// ── Doctor Home ──
import 'package:rafiq/features/doctor_side/doctor_home/data/datasources/doctor_home_remote_datasource.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/repositories/doctor_home_repository_impl.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/repositories/doctor_home_repository.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/usecases/get_doctor_home_data_usecase.dart';
import 'package:rafiq/features/doctor_side/doctor_home/presentation/bloc/doctor_home_cubit.dart';

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
  sl.registerFactory<DoctorHomeRemoteDataSource>(
    () => DoctorHomeRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerFactory<DoctorHomeRepository>(
    () => DoctorHomeRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerFactory(() => GetDoctorHomeDataUsecase(sl()));

  sl.registerFactory(() => DoctorHomeCubit(getDoctorHomeData: sl()));

  // ── Doctor Appointments ───────────────────────────────────────
  sl.registerFactory<DoctorAppointmentsDatasource>(
    () => DoctorAppointmentsRemoteDatasource(dio: sl()),
  );

  sl.registerFactory<DoctorAppointmentsRepository>(
    () => DoctorAppointmentsRepositoryImpl(sl()),
  );

  sl.registerFactory(() => GetWeeklyScheduleUsecase(sl()));
  sl.registerFactory(() => CancelFullDayUsecase(sl()));
  sl.registerFactory(() => EditSlotUsecase(sl()));
  sl.registerFactory(() => CancelSlotUsecase(sl()));
  sl.registerFactory(() => AddAvailabilityUsecase(sl()));

  sl.registerFactory(
    () => DoctorAppointmentsCubit(
      getWeeklySchedule: sl(),
      cancelFullDay: sl(),
      editSlot: sl(),
      cancelSlot: sl(),
      addAvailability: sl(),
      doctorId: '',
    ),
  );

  // ── Doctor Articles ───────────────────────────────────────
  sl.registerFactory<DoctorArticleRemoteDatasource>(
    () => DoctorArticleRemoteDatasourceImpl(sl()),
  );

  sl.registerFactory<DoctorArticleRepository>(
    () => DoctorArticleRepositoryImpl(sl()),
  );

  sl.registerFactory(() => GetMyArticlesUseCase(sl()));
  sl.registerFactory(() => AddArticleUseCase(sl()));
  sl.registerFactory(() => DeleteArticleUseCase(sl()));

  sl.registerFactory(
    () => DoctorArticlesCubit(
      getMyArticles: sl(),
      addArticle: sl(),
      deleteArticle: sl(),
    ),
  );

  // ── Doctors Feature ──────────────────────────────────────
  sl.registerFactory<DoctorsRemoteDatasource>(
    () => DoctorsRemoteDatasourceImpl(sl()),
  );

  sl.registerFactory<DoctorsRepository>(() => DoctorsRepositoryImpl(sl()));

  sl.registerFactory(() => GetDoctorsUseCase(sl()));
  sl.registerFactory(() => GetDoctorProfileUseCase(sl()));

  sl.registerFactory(() => DoctorsCubit(sl()));
  sl.registerFactory(() => DoctorProfileCubit(sl()));
  // ─────────────────────────────────────────────────────────

  // ── Patient Bookings ──────────────────────────────────────
  sl.registerFactory<PatientBookingsDatasource>(
    () => PatientBookingsDatasourceImpl(sl()),
  );
  sl.registerFactory<PatientBookingsRepository>(
    () => PatientBookingsRepositoryImpl(sl()),
  );
  sl.registerFactory(() => GetMyAppointmentsUseCase(sl()));
  sl.registerFactory(() => patient_uc.GetAppointmentDetailsUseCase(sl()));
  sl.registerFactory(() => CancelAppointmentUseCase(sl()));
  sl.registerFactory(() => RescheduleAppointmentUseCase(sl()));
  sl.registerFactory(
    () => AppointmentsCubit(
      getAppointmentsUseCase: sl(),
      getDetailsUseCase: sl(),
      cancelUseCase: sl(),
      rescheduleUseCase: sl(),
    ),
  );

  // ── Patient Bookings ──────────────────────────────────────
  

  // ── Book Appointment ──────────────────────────────────────
  sl.registerFactory<BookingRemoteDatasource>(
    () => BookingRemoteDatasourceImpl(sl()),
  );
  sl.registerFactory<BookingRepository>(() => BookingRepositoryImpl(sl()));

  sl.registerFactory(() => booking_uc.GetAvailableSlotsUseCase(sl()));
  sl.registerFactory(() => booking_uc.BookAppointmentUseCase(sl()));

  sl.registerFactory(
    () => BookAppointmentCubit(
      sl<booking_uc.GetAvailableSlotsUseCase>(),
      sl<booking_uc.BookAppointmentUseCase>(),
    ),
  );

  // ──────────────────────────────────────────────────────────
}
