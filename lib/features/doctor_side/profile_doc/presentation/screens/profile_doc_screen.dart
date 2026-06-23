import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/details_card.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/services_card.dart';
import 'package:rafiq/features/doctor_side/profile_doc/widgets/options_doc_card.dart';

class ProfileDocScreen extends StatefulWidget {
  const ProfileDocScreen({super.key});

  @override
  State<ProfileDocScreen> createState() => _ProfileDocScreenState();
}

class _ProfileDocScreenState extends State<ProfileDocScreen> {
  late DoctorProfileCubit doctorprofileCubit;
  String role = '';

  Future<void> loadRole() async {
    role = await AuthSharedPrefs().getRole();
    print("PROFILE ROLE => $role");
    setState(() {});
  }

  @override
  void initState() {
    print("Doctor PROFILE OPENED");
    doctorprofileCubit = context.read<DoctorProfileCubit>();
    doctorprofileCubit.getDoctorProfile();
    loadRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        if (state is DoctorProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DoctorProfileError) {
          return Text(state.message);
        }
        if (state is DoctorProfileLoaded) {
          final Doctorprofile = state.profile;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("حسابي", style: AppTypography.appBarTitelStyle),
              actions: [
                Padding(
                  padding: REdgeInsets.only(left: 16),
                  child: InkWell(child: SvgPicture.asset(SvgManger.edit)),
                ),
              ],
            ),
            body: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CardWidget(
                      width: double.infinity,
                      verticalPadding: 16.r,
                      widget: Column(
                        children: [
                          Image.asset(IconManger.profileImg),
                          HeightSpace(8),
                          Text(
                            Doctorprofile.fullName,
                            style: AppTypography.profileNameStyle,
                          ),
                          HeightSpace(8),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Padding(
                              padding: REdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              child: Text(
                                "دكتور",
                                style: AppTypography.profileRoleStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    HeightSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DetailsCard(
                          title: 'العمر',
                          value: Doctorprofile.age.toString(),
                        ),
                        WidthSpace(16),
                        DetailsCard(
                          title: 'الجنس',
                          value: Doctorprofile.gender,
                        ),
                        WidthSpace(16),
                        DetailsCard(
                          title: 'الحجوزات',
                          value: Doctorprofile.appointmentsCount.toString(),
                        ),
                      ],
                    ),
                    HeightSpace(20),

                    Row(
                      children: [
                        ServicesCard(
                          onTap: () {},
                          icon: SvgManger.calendar,
                          serviceName: "حجوزاتي",
                          servicesDetails: "التحكم في المواعيد",
                          borderColor: AppColors.primary,
                          textColor: AppColors.primary,
                        ),
                        WidthSpace(20),
                        ServicesCard(
                          onTap: () {},
                          icon: SvgManger.files,
                          textColor: AppColors.purple,
                          serviceName: "جدول اليوم",
                          servicesDetails: "عرض حجوزات اليوم",
                          borderColor: AppColors.purple,
                        ),
                      ],
                    ),
                    HeightSpace(16),
                    Row(
                      children: [
                        ServicesCard(
                          onTap: () {},
                          icon: SvgManger.articles,
                          serviceName: "مقالاتي",
                          servicesDetails: "لعرض المقالات",
                          borderColor: AppColors.warning,
                          textColor: AppColors.warning,
                        ),
                        WidthSpace(20),
                        ServicesCard(
                          onTap: () {
                            context.navigateTo(Routes.profits);
                          },

                          icon: SvgManger.money,
                          serviceName: "الدفع والارباح",
                          servicesDetails: " عرض سجل المعاملات",
                          borderColor: AppColors.darkGreen,
                          textColor: AppColors.darkGreen,
                        ),
                      ],
                    ),
                    HeightSpace(20),
                    OptionsDocCard(),
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
