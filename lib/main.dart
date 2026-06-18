import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/api/api_interceptors.dart';
import 'package:rafiq/core/utils/constants.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/authentication/data/datasources/remote/auth_api_remote_data_source.dart';
import 'package:rafiq/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:rafiq/features/authentication/domain/usecases/login_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/register_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/reset_pass_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/send_otp_usecase.dart';
import 'package:rafiq/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:rafiq/features/authentication/presentation/bloc/authentication_cubit.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/localization_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // ── Dio instance واحد مشترك ────────────────────────────────────────────────
  final dio =
      Dio(
          BaseOptions(
            baseUrl: AppConstants.baseUrl,
            connectTimeout: AppConstants.connectionTimeout,
            receiveTimeout: AppConstants.receiveTimeout,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        )
        ..interceptors.add(TokenInterceptor())
        ..interceptors.add(ApiInterceptor());

  // ── Auth dependencies (instance واحد للـ repo مشترك بين كل الـ usecases) ──
  final authRepo = AuthRepositoryImpl(
    remoteDataSource: AuthApiRemoteDataSource(dio: dio),
    localDataSource: AuthSharedPrefs(),
  );
  // ── Profile dependencies ───────────────────────────────────────────────────

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationManager.supportedLocales,
      path: LocalizationManager.translationsPath,
      fallbackLocale: LocalizationManager.fallbackLocale,
      startLocale: LocalizationManager.fallbackLocale,
      child:
          // ── Auth Cubit ─────────────────────────────────────────────────────
          BlocProvider(
            create: (_) => AuthenticationCubit(
              loginUsecase: LoginUsecase(authRepository: authRepo),
              registerUsecase: RegisterUsecase(authRepo),
              verifyResetOtpUseCase: VerifyResetOtpUseCase(authRepo),
              sendOtpUsecase: SendResetOtpUseCase(authRepo),
              resetPassUsecase: ResetPassUsecase(authRepo),
            ),

            // ── Profile Cubit ──────────────────────────────────────────────────
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
          themeMode: ThemeMode.light,
          initialRoute: Routes.userTypeScreen,
          onGenerateRoute: AppRouter.generateRoute,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
