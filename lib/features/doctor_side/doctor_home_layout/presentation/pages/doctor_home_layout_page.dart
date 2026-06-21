import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/injection_container.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/pages/doctor_appointments_screen.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_cubit.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/pages/doctor_articles_screen.dart';
import 'package:rafiq/features/doctor_side/doctor_home/presentation/pages/doctor_home_screen.dart';
<<<<<<< HEAD
import 'package:rafiq/features/doctor_side/profile_doc/data/data_source/profile_doctor_remote_api_data_source.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/repo/profile_doctor_repository_impl.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/change_doctor_pass_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/create_coupon_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/profile_doctor_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/update_clinic_record_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/update_doctor_profile_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/update_payment_info_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/screens/profile_doc_screen.dart';
=======
import 'package:rafiq/features/profile_doc/presentation/screens/profile_doc_screen.dart';
>>>>>>> c4a9fa49c3c9a99d6d324d43827c68344bf54012

class DoctorHomeLayout extends StatefulWidget {
  final int initialIndex;
  const DoctorHomeLayout({super.key, this.initialIndex = 0});

  @override
  State<DoctorHomeLayout> createState() => _DoctorHomeLayoutState();
}

class _DoctorHomeLayoutState extends State<DoctorHomeLayout> {
  late int currentIndex;

  final List<Widget> tabs = [
<<<<<<< HEAD
    DoctorHomeScreen(),
    DoctorAppointmentsScreen(
      doctorId: '',
      doctorName: '',
    ), // DoctorAppointmentsScreen()
    Center(child: Text("مقالاتي")), // DoctorArticlesScreen()
    ProfileDocScreen(),
    // ProfileTab()
=======
    const DoctorHomeScreen(),
    const DoctorAppointmentsScreen(
      doctorId: '',
      doctorName: '',
    ), // DoctorAppointmentsScreen()
    BlocProvider(
      create: (_) => sl<DoctorArticlesCubit>(),
      child:  const DoctorArticlesScreen(),
    ),
    const ProfileDocScreen(),
>>>>>>> c4a9fa49c3c9a99d6d324d43827c68344bf54012
  ];

  @override
  void initState() {
    super.initState();
    print("DOCTOR HOME LAYOUT OPENED");
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorProfileCubit(
        updatePaymentInfoUseCase: UpdatePaymentInfoUseCase(
          repository: ProfileDoctorRepositoryImpl(
            remoteDataSource: ProfileDoctorRemoteApiDataSource(),
          ),
        ),
        createCouponUseCase: CreateCouponUseCase(
          repository: ProfileDoctorRepositoryImpl(
            remoteDataSource: ProfileDoctorRemoteApiDataSource(),
          ),
        ),
        getProfileUsecase: GetProfileDoctorUsecase(
          repository: ProfileDoctorRepositoryImpl(
            remoteDataSource: ProfileDoctorRemoteApiDataSource(),
          ),
        ),
        changePassUseCase: ChangeDoctorPassUseCase(
          repository: ProfileDoctorRepositoryImpl(
            remoteDataSource: ProfileDoctorRemoteApiDataSource(),
          ),
        ),
        updateDoctorProfileUseCase: UpdateDoctorProfileUseCase(
          repository: ProfileDoctorRepositoryImpl(
            remoteDataSource: ProfileDoctorRemoteApiDataSource(),
          ),
        ),
        updateClinicInfoUseCase: UpdateClinicInfoUseCase(
          repository: ProfileDoctorRepositoryImpl(
            remoteDataSource: ProfileDoctorRemoteApiDataSource(),
          ),
        ),
      ),
      child: Scaffold(
        body: tabs[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(fontSize: 12.sp),
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'حجوزاتي',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                label: 'المقالات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'حسابي',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
