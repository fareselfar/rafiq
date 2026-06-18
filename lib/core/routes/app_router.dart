import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rafiq/features/articles/presentation/pages/articles_screen.dart';
import 'package:rafiq/features/authentication/data/models/reset_pass_arrgs.dart';
import 'package:rafiq/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/get_start.dart';
import 'package:rafiq/features/authentication/presentation/screens/login_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/reset_pass_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/register_screen.dart';
import 'package:rafiq/features/doctor_side/doctor_home_layout/presentation/pages/doctor_home_layout_page.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/presentation/screens/doctor_notification_screen.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/presentation/screens/change_doc_pass.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/presentation/screens/edit_clinic.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/presentation/screens/edit_doc_profile.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/presentation/screens/payment_screen.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/presentation/screens/profits.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/screens/profile_doc_screen.dart';
import 'package:rafiq/features/patient_profile/edit_profile/presentation/pages/edit_medical_files.dart';
import 'package:rafiq/features/patient_profile/edit_profile/presentation/pages/medical_files.dart';
import 'package:rafiq/features/patient_profile/edit_profile/presentation/pages/edit_profile_page.dart';
import 'package:rafiq/features/patient_profile/edit_profile/presentation/pages/upload_file_screen.dart';
import 'package:rafiq/features/patient_bookings/data/models/payment_arguments.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_bookings/presentation/pages/book_appointment_screen.dart';
import 'package:rafiq/features/patient_bookings/presentation/pages/booking_details_screen.dart';
import 'package:rafiq/features/patient_bookings/presentation/pages/booking_success_screen.dart';
import 'package:rafiq/features/patient_bookings/presentation/pages/patient_bookings_screen.dart';
import 'package:rafiq/features/patient_bookings/presentation/pages/edit_appointment_screen.dart';
import 'package:rafiq/features/patient_bookings/presentation/pages/payment_screen.dart';
import 'package:rafiq/features/authentication/presentation/screens/success_reset_screen.dart';
import 'package:rafiq/features/chatbot/presentation/pages/chatbot_page.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/pages/doctor_details_screen.dart';
import 'package:rafiq/features/doctors/presentation/pages/doctors_screen.dart';
import 'package:rafiq/features/patient_home/data/datasources/home_remote_datasource.dart';
import 'package:rafiq/features/patient_home/data/repositories/home_repository_impl.dart';
import 'package:rafiq/features/patient_home/domain/usecases/search_doctor_usecase.dart';
import 'package:rafiq/features/patient_home/presentation/bloc/home_cubit.dart';
import 'package:rafiq/features/patient_home/presentation/pages/home.dart';
import 'package:rafiq/features/patient_home/presentation/pages/home_search_screen.dart';
import 'package:rafiq/features/patient_home_layout/presentation/pages/patient_home_layout_screen.dart';
import 'package:rafiq/features/onbording/screens/onbording_screens.dart';
import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/edit_profile/presentation/pages/change_password.dart';
import 'package:rafiq/features/patient_profile/presentation/pages/profile_page.dart';

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
        final userType = settings.arguments as UserType? ?? UserType.patient;
        return _buildRoute(LoginScreen(userType: userType), settings);
      case Routes.forgetPassword:
        final String? email = settings.arguments as String?;
        return _buildRoute(ForgetPassword(email: email), settings);
      case Routes.otpScreen:
        final email = settings.arguments as String;
        return _buildRoute(OtpScreen(email: email), settings);

      case Routes.register:
        final userType = settings.arguments as UserType? ?? UserType.patient;
        return _buildRoute(RegisterScreen(userType: userType), settings);

      // case Routes.docLogin:
      //   return _buildRoute(const LoginDocScreen(), settings);
      // case Routes.docRegister:
      //   return _buildRoute(
      //     const RegisterDocScreen(userType: UserType.doctor),
      //     settings,
      //   );
      case Routes.successResetPass:
        return _buildRoute(const SuccessResetScreen(), settings);
      case Routes.patientHome:
        final initialIndex = settings.arguments as int? ?? 0;
        return _buildRoute(
          PatientHomeLayout(initialIndex: initialIndex),
          settings,
        );
      case Routes.doctorsScreen:
        return _buildRoute(const DoctorsScreen(), settings);
      case Routes.doctorDetailsScreen:
        final doctor = settings.arguments as DoctorsEntity;
        return _buildRoute(DoctorDetailsScreen(doctor: doctor), settings);
      case Routes.bookAppointmentScreen:
        final booking = settings.arguments as BookingEntity;
        return _buildRoute(BookAppointmentScreen(booking: booking), settings);

      case Routes.paymentScreen:
        final args = settings.arguments as PaymentArguments;
        return _buildRoute(
          PaymentScreen(
            booking: args.booking,
            selectedDate: args.date,
            selectedTime: args.time,
          ),
          settings,
        );

      case Routes.bookingSuccessScreen:
        final args = settings.arguments as PaymentArguments;
        return _buildRoute(
          BookingSuccessScreen(
            booking: args.booking,
            selectedDate: args.date,
            selectedTime: args.time,
          ),
          settings,
        );
      case Routes.bookingDetailsScreen:
        final args = settings.arguments as BookingEntity;
        return _buildRoute(BookingDetailsScreen(booking: args), settings);
      case Routes.editAppointmentScreen:
        final booking = settings.arguments as BookingEntity;
        return _buildRoute(EditAppointmentScreen(booking: booking), settings);

      case Routes.specializationScreen:
        return _buildRoute(SpecializationsScreen(), settings);

      case Routes.paymentInfo:
        final cubit = settings.arguments as DoctorProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: PaymentScreenInfo()),
          settings,
        );

      case Routes.editScreen:
        final cubit = settings.arguments as ProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: const EditProfilePage()),
          settings,
        );
      case Routes.chatBotScreen:
        return _buildRoute(const ChatBotScreen(), settings);
      case Routes.editFiels:
        final cubit = settings.arguments as ProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: const MedicalFiels()),
          settings,
        );
      case Routes.uploadFiels:
        final cubit = settings.arguments as ProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: const UploadFileScreen()),
          settings,
        );
      case Routes.profile:
        return _buildRoute(const ProfileTab(), settings);
      case Routes.articlesScreen:
        return _buildRoute(const ArticlesScreen(), settings);
      case Routes.changePassword:
        final cubit = settings.arguments as ProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: const ChangePassword()),
          settings,
        );

      case Routes.docProfile:
        return _buildRoute(const ProfileDocScreen(), settings);

      case Routes.homeSearchScreen:
        return _buildRoute(
          BlocProvider(
            create: (_) => SearchCubit(
              searchDoctorsUseCase: SearchDoctorsUseCase(
                repository: HomeRepositoryImpl(
                  remoteDataSource: HomeRemoteDataSourceImpl(),
                ),
              ),
            ),
            child: const HomeSearchScreen(),
          ),
          settings,
        );
      case Routes.doctorNotificationScreen:
        return _buildRoute(const DoctorNotificationScreen(), settings);
      case Routes.changeDocPassword:
        final cubit = settings.arguments as DoctorProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: const ChangeDoctorPassword()),
          settings,
        );
      case Routes.editDocClinic:
        final cubit = settings.arguments as DoctorProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: const EditClinic()),
          settings,
        );
      case Routes.profits:
        return _buildRoute(const ProfitsScrren(), settings);
      case Routes.editDocProfile:
        final args = settings.arguments as Map<String, dynamic>;
        final profile = args['profile'] as DoctorProfileEntity;
        final cubit = args['cubit'] as DoctorProfileCubit;
        return _buildRoute(
          BlocProvider.value(
            value: cubit,
            child: EditDocProfileScreen(profile: profile),
          ),
          settings,
        );

      case Routes.resetPass:
        final args = settings.arguments as ResetPassArgs;
        return _buildRoute(
          ResetPassScreen(email: args.email, otp: args.otp),
          settings,
        );

      case Routes.bookingsScreen:
        return _buildRoute(const PatientBookingsScreen(), settings);

      case Routes.doctorHome:
        final initialIndex = settings.arguments as int? ?? 0;
        return _buildRoute(
          DoctorHomeLayout(initialIndex: initialIndex),
          settings,
        );
      case Routes.home:
        return _buildRoute(Home(), settings);
      case Routes.editMedicalFileScreen:
        final cubit = settings.arguments as ProfileCubit;
        return _buildRoute(
          BlocProvider.value(value: cubit, child: EditMedicalFileScreen()),
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
