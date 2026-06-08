import 'package:flutter/material.dart';
import 'package:rafiq/features/Auth_doc/presentation/screens/login_screen.dart';
import 'package:rafiq/features/Auth_doc/presentation/screens/register_screen.dart';
import 'package:rafiq/features/articles/presentation/pages/articles_screen.dart';
import 'package:rafiq/features/authentication/data/models/reset_pass_arrgs.dart';
import 'package:rafiq/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/get_start.dart';
import 'package:rafiq/features/authentication/presentation/screens/login_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/reset_pass_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/register_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/success_reset_screen.dart';
import 'package:rafiq/features/chatbot/presentation/pages/chatbot_page.dart';

import 'package:rafiq/features/home_layout/presentation/pages/home_layout_screen.dart';

import 'package:rafiq/features/onbording/screens/onbording_screens.dart';
import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/features/profile/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:rafiq/features/profile/presentation/pages/edit_fiels.dart';
import 'package:rafiq/features/profile/presentation/pages/profile_page.dart';
import 'package:rafiq/features/profile/presentation/pages/upload_file_screen.dart';
import 'package:rafiq/features/profile/presentation/pages/change_password.dart';
import 'package:rafiq/features/profile_doc/edit_profile_doc/presentation/screens/change_doc_pass.dart';
import 'package:rafiq/features/profile_doc/edit_profile_doc/presentation/screens/edit_clinic.dart';
import 'package:rafiq/features/profile_doc/edit_profile_doc/presentation/screens/edit_doc_profile.dart';
import 'package:rafiq/features/profile_doc/edit_profile_doc/presentation/screens/payment_screen.dart';
import 'package:rafiq/features/profile_doc/edit_profile_doc/presentation/screens/profits.dart';
import 'package:rafiq/features/profile_doc/presentation/screens/profile_doc_screen.dart';

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
        final userType = settings.arguments as UserType;
        return _buildRoute(GetStart(selectedUserType: userType), settings);
      case Routes.login:
        return _buildRoute(const LoginScreen(), settings);
      case Routes.forgetPassword:
        final String? email = settings.arguments as String?;
        return _buildRoute(ForgetPassword(email: email), settings);
      case Routes.otpScreen:
        final email = settings.arguments as String;
        return _buildRoute(OtpScreen(email: email), settings);
      case Routes.register:
        return _buildRoute(
          const RegisterScreen(userType: UserType.patient),
          settings,
        );
      case Routes.docLogin:
        return _buildRoute(const LoginDocScreen(), settings);
      case Routes.docRegister:
        return _buildRoute(
          const RegisterDocScreen(userType: UserType.doctor),
          settings,
        );
      case Routes.successResetPass:
        return _buildRoute(const SuccessResetScreen(), settings);
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
      case Routes.docProfile:
        return _buildRoute(const ProfileDocScreen(), settings);
      case Routes.changeDocPassword:
        return _buildRoute(const ChangeDocPassword(), settings);
      case Routes.editDocClinic:
        return _buildRoute(const EditClinic(), settings);
      case Routes.profits:
        return _buildRoute(const ProfitsScrren(), settings);
      case Routes.paymentInfo:
        return _buildRoute(const PaymentScreen(), settings);
      case Routes.editDocProfile:
        return _buildRoute(const EditDocProfileScreen(), settings);
      case Routes.resetPass:
        final args = settings.arguments as ResetPassArgs;
        return _buildRoute(
          ResetPassScreen(email: args.email, otp: args.otp),
          settings,
        );
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
