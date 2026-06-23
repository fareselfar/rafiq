import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/features/patient_bookings/presentation/pages/patient_bookings_screen.dart';
import 'package:rafiq/features/chatbot/presentation/pages/chatbot_page.dart';
import 'package:rafiq/features/doctors/presentation/pages/doctors_screen.dart';
import 'package:rafiq/features/patient_home/presentation/pages/patient_home.dart';
import 'package:rafiq/features/patient_profile/data/datasources/profile_remote_api_data_source.dart';
import 'package:rafiq/features/patient_profile/data/repositories/profile_repository_impl.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/change_pass_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/get_files_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/profile_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/update_medical_record_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/update_profile_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/upload_files_usecase.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/pages/profile_page.dart';

class PatientHomeLayout extends StatefulWidget {
  final int initialIndex;

  const PatientHomeLayout({super.key, this.initialIndex = 0});

  @override
  State<PatientHomeLayout> createState() => _PatientHomeLayoutState();
}

class _PatientHomeLayoutState extends State<PatientHomeLayout> {
  final profileRepo = ProfileRepositoryImpl(
    remoteDataSource: ProfileRemoteApiDataSource(),
  );
  late int currentIndex;
  bool _isNavBarVisible = true;

  late final List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    print("PATIENT HOME LAYOUT OPENED");
    currentIndex = widget.initialIndex;
    tabs = [
      PatientHomeScreen(),
      ChatBotScreen(),
      DoctorsScreen(),
      PatientBookingsScreen(),
      ProfileTab(),
    ];
    _updateNavVisibility(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(
        updateMedicalRecordUseCase: UpdateMedicalRecordUseCase(
          repository: profileRepo,
        ),
        getFilesUseCase: GetFilesUseCase(repository: profileRepo),
        uploadFileUseCase: UploadFileUseCase(repository: profileRepo),
        updateProfileUseCase: UpdateProfileUseCase(repository: profileRepo),
        changePassUseCase: ChangePassUseCase(repository: profileRepo),
        getProfileUsecase: GetProfileUsecase(repository: profileRepo),
      )..getProfile(),
      child: PopScope(
        canPop: currentIndex == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          if (currentIndex != 0) {
            setState(() {
              currentIndex = 0;
              _updateNavVisibility(0);
            });
          }
        },
        child: Scaffold(
          body: tabs[currentIndex],
          bottomNavigationBar: _isNavBarVisible ? _buttonNavBar() : null,
        ),
      ),
    );
  }

  void _updateNavVisibility(int index) {
    _isNavBarVisible = index != 1;
  }

  Widget _buttonNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: currentIndex == 0
              ? const Icon(Icons.home)
              : const Icon(Icons.home_outlined),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.chatBot),
          icon: SvgPicture.asset(SvgManger.unChatBot),
          label: 'رفيقك',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.doctor),
          icon: SvgPicture.asset(SvgManger.unDoctor),
          label: 'الأطباء',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.ticket),
          icon: SvgPicture.asset(SvgManger.unTicket),
          label: 'حجوزاتي',
        ),
        BottomNavigationBarItem(
          icon: currentIndex == 4
              ? const Icon(Icons.person)
              : const Icon(Icons.person_outline),
          label: 'حسابي',
        ),
      ],
    );
  }

  void _onTap(int newIndex) {
    if (currentIndex == newIndex) return;

    setState(() {
      currentIndex = newIndex;
      _updateNavVisibility(newIndex);
    });
  }
}
