import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/details_card.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/options_card.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/services_card.dart';

import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/special_container.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late ProfileCubit profileCubit;
  String role = '';

  Future<void> loadRole() async {
    role = await AuthSharedPrefs().getRole();

    setState(() {});
  }

  @override
  void initState() {
    profileCubit = context.read<ProfileCubit>();
    profileCubit.getProfile();
    loadRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileError) {
          return Text(state.message);
        }
        if (state is ProfileLoaded) {
          final profile = state.profile;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('ملفي الشخصي', style: AppTypography.appBarTitelStyle),
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
                            state.profile.fullName,
                            style: AppTypography.profileNameStyle,
                          ),
                          HeightSpace(8),
                          SpecialContainer(
                            title: role == "Patient" ? "مستخدم" : "طبيب",
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
                          value: profile.age.toString(),
                        ),
                        WidthSpace(16),
                        DetailsCard(title: 'الجنس', value: 'ذكر'),
                        WidthSpace(16),
                        DetailsCard(
                          title: 'الحجوزات',
                          value: profile.appointmentsCount.toString(),
                        ),
                      ],
                    ),
                    HeightSpace(20),
                    Text(
                      "الخدمات السريعة",
                      style: AppTypography.profileServicesStyle,
                      textAlign: TextAlign.start,
                    ),
                    HeightSpace(8),
                    Row(
                      children: [
                        ServicesCard(
                          onTap: () {},
                          icon: SvgManger.calendar,
                          serviceName: "حجوزاتي",
                          servicesDetails: "مواعيدك القادمة",
                          borderColor: AppColors.primary,
                        ),
                        WidthSpace(20),
                        ServicesCard(
                          onTap: () {},
                          icon: SvgManger.files,
                          textColor: AppColors.purple,
                          serviceName: "ملفاتي الطبية",
                          servicesDetails: "تقارير وتحاليل",
                          borderColor: AppColors.purple,
                        ),
                      ],
                    ),
                    HeightSpace(16),
                    Row(
                      children: [
                        ServicesCard(
                          onTap: () {},
                          icon: SvgManger.upload,
                          serviceName: "حجوزاتي",
                          servicesDetails: "مواعيدك القادمة",
                          borderColor: AppColors.primary,
                        ),
                        WidthSpace(20),
                        ServicesCard(
                          onTap: () {},

                          icon: SvgManger.articles,
                          serviceName: "ملفاتي الطبية",
                          servicesDetails: "تقارير وتحاليل",
                          borderColor: AppColors.primary,
                        ),
                      ],
                    ),
                    HeightSpace(20),
                    OptionsCard(),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
