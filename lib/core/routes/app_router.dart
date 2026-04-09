import 'package:flutter/material.dart';
import 'package:rafiq/features/articles/presentation/pages/articles_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/get_start.dart';
import 'package:rafiq/features/authentication/presentation/screens/login_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/register_screen.dart';
import 'package:rafiq/features/chatbot/presentation/pages/chatbot_page.dart';

import 'package:rafiq/features/home_layout/presentation/pages/home_layout_screen.dart';

import 'package:rafiq/features/onbording/screens/onbording_screens.dart';
import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/features/profile/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:rafiq/features/profile/presentation/pages/edit_fiels.dart';
import 'package:rafiq/features/profile/presentation/pages/profile_page.dart';
import 'package:rafiq/features/profile/presentation/pages/upload_file_screen.dart';
import 'package:rafiq/features/profile/presentation/pages/change_password.dart';

import 'package:rafiq/features/specialization/presentation/pages/specializations_screen.dart';
import 'package:rafiq/features/splash/splash_screen.dart';
import 'package:rafiq/features/verify_otp/screens/verify_otp_screen.dart';
import 'routes.dart';
import '../../features/user_type/user_type_screen.dart';

/// Application Router
class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _buildRoute(const SplashScreen(), settings);
      case Routes.userTypeScreen:
        return _buildRoute(const UserTypeScreen(), settings);
      case Routes.onbordingScreen:
        final userType = settings.arguments as UserType?;
        return _buildRoute(
          OnboardingScreen(selectedUserType: userType),
          settings,
        );
      case Routes.getStart:
        return _buildRoute(const GetStart(), settings);
      case Routes.login:
        return _buildRoute(const LoginScreen(), settings);
      case Routes.forgetPassword:
        final String? email = settings.arguments as String?;
        return _buildRoute(ForgetPassword(email: email), settings);
      case Routes.otpScreen:
        return _buildRoute(const OtpScreen(), settings);
      case Routes.register:
        return _buildRoute(const RegisterScreen(), settings);
      case Routes.home:
        return _buildRoute(const HomeScreen(), settings);
      case Routes.specializationScreen:
        return _buildRoute(SpecializationsScreen(), settings);
      case Routes.editScreen:
        return _buildRoute(const EditProfilePage(), settings);
      case Routes.chatBotScreen:
        return _buildRoute(const ChatBotScreen(), settings);
      case Routes.editFiels:
        return _buildRoute(const EditFiels(), settings);
      case Routes.uploadFiels:
        return _buildRoute(const UploadFileScreen(), settings);
      case Routes.profile:
        return _buildRoute(const ProfileTab(), settings);
      case Routes.articlesScreen:
        return _buildRoute(const ArticlesScreen(), settings);
      case Routes.changePassword:
        return _buildRoute(const ChangePassword(), settings);
      default:
        return _buildRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
