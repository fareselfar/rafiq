import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/splash/cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        switch (state) {
          case SplashFirstLaunch():
            Navigator.pushReplacementNamed(context, Routes.onbordingScreen);
          case SplashAuthenticated(:final isDoctor):
            Navigator.pushReplacementNamed(
              context,
              isDoctor ? Routes.doctorHome : Routes.patientHome,
            );
          case SplashUnauthenticated():
            Navigator.pushReplacementNamed(context, Routes.userTypeScreen);
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: 200.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: Image.asset(
                    'assets/images/Rafiq_logo.png',
                    width: 125,
                    height: 125,
                  ),
                ),
                SizedBox(
                  width: 160.w,
                  child: LinearProgressIndicator(
                    minHeight: 5.h,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
