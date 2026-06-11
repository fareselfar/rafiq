import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/authentication/data/datasources/remote/auth_api_remote_data_source.dart';
import 'package:rafiq/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:rafiq/features/authentication/domain/usecases/login_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/register_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/reset_pass_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:rafiq/features/authentication/presentation/bloc/authentication_cubit.dart';
import 'package:rafiq/features/patient_profile/data/datasources/profile_remote_api_data_source.dart';
import 'package:rafiq/features/patient_profile/data/repositories/profile_repository_impl.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/change_pass_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/profile_usecase.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';

import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/localization_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // عشان ميقلبش
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize dependency injection
  // await di.init();

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationManager.supportedLocales,
      path: LocalizationManager.translationsPath,
      fallbackLocale: LocalizationManager.fallbackLocale,
      startLocale: LocalizationManager.fallbackLocale,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationCubit(
              verifyResetOtpUseCase: VerifyResetOtpUseCase(
                AuthRepoImpl(
                  authRemoteDataSource: AuthApiRemoteDataSource(),
                  authLocalDataSource: AuthSharedPrefs(),
                ),
              ),
              sendOtpUsecase: SendResetOtpUseCase(
                AuthRepoImpl(
                  authRemoteDataSource: AuthApiRemoteDataSource(),
                  authLocalDataSource: AuthSharedPrefs(),
                ),
              ),
              registerUsecase: RegisterUsecase(
                authenticationRepository: AuthRepoImpl(
                  authRemoteDataSource: AuthApiRemoteDataSource(),
                  authLocalDataSource: AuthSharedPrefs(),
                ),
              ),

              loginUsecase: LoginUsecase(
                authenticationRepository: AuthRepoImpl(
                  authRemoteDataSource: AuthApiRemoteDataSource(),
                  authLocalDataSource: AuthSharedPrefs(),
                ),
              ),
              resetPassUsecase: ResetPassUsecase(
                AuthRepoImpl(
                  authRemoteDataSource: AuthApiRemoteDataSource(),
                  authLocalDataSource: AuthSharedPrefs(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
              changePassUseCase: ChangePassUseCase(
                repository: ProfileRepositoryImpl(
                  remoteDataSource: ProfileRemoteApiDataSource(),
                ),
              ),
              getProfileUsecase: GetProfileUsecase(
                repository: ProfileRepositoryImpl(
                  remoteDataSource: ProfileRemoteApiDataSource(),
                ),
              ),
            ),
          ),
        ],
        child: const Rafiq(),
      ),
    ),
  );
}

class Rafiq extends StatelessWidget {
  const Rafiq({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Rafiq',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,

          initialRoute: Routes.userTypeScreen,
          themeMode: ThemeMode.light,

          onGenerateRoute: AppRouter.generateRoute,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
