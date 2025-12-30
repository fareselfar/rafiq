import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/core/routes/app_router.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';
import 'package:rafiq/features/user_type/custom_user_type_card.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  UserType? selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              Text(
                'اختر نوع حسابك للحصول على تجربة مخصصة',
                textAlign: TextAlign.start,
                style: AppTypography.primaryHeadLinesStyle,
              ),

              HeightSpace(16),

              Text(
                'من فضلك حدّد إذا كنت ستستخدم التطبيق\nكمريض أو كطبيب.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge,
              ),

              HeightSpace(29),

              // card
              Row(
                children: [
                  Expanded(
                    child: UserTypeCard(
                      iconCaracterPath: 'assets/icons/doctor.svg',

                      description:
                          'لإدارة مواعيدك\nوملفك المهني\nوالتواصل مع\nالمرضى بكفاءة',

                      startAs: 'ابدأ كطبيب',

                      isSelected: selectedUserType == UserType.doctor,
                      selectedColor: AppColors.selectedDoctor,
                      unSelectedColor: AppColors.unSelectedText,
                      borderColor: selectedUserType == UserType.doctor
                          ? AppColors.selectedDoctor
                          : AppColors.unSelectedText,
                      onTap: () {
                        setState(() {
                          selectedUserType = UserType.doctor;
                        });
                      },
                    ),
                  ),

                  WidthSpace(16),

                  Expanded(
                    child: UserTypeCard(
                      iconCaracterPath: 'assets/icons/person.svg',

                      description:
                          'لحجز المواعيد\nوتشخيص الأعراض\nوالحصول على\nاستشارات طبية',

                      startAs: 'ابدأ كمستخدم',

                      isSelected: selectedUserType == UserType.patient,
                      selectedColor: AppColors.primary,
                      unSelectedColor: AppColors.unSelectedText,

                      borderColor: selectedUserType == UserType.patient
                          ? AppColors.primary
                          : AppColors.unSelectedText,
                      onTap: () {
                        setState(() {
                          selectedUserType = UserType.patient;
                        });
                      },
                    ),
                  ),
                ],
              ),

              HeightSpace(40),

              // Button
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  onPressed: selectedUserType == null
                      ? null
                      : () {
                          AppRouter.navigateTo(
                            context,
                            Routes.onbordingScreen,
                            arguments: selectedUserType,
                          );
                        },
                  text: 'هيا بنا الآن',
                  textStyle: AppTypography.button,
                  width: 237.w,
                  height: 52.h,
                  borderRadius: 8.r,
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
