import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class DoctorActionButton extends StatelessWidget {
  final bool isAvailable;
  final DoctorsEntity doctor;
  const DoctorActionButton({
    super.key,
    required this.isAvailable,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: isAvailable ? "احجز الآن" : "يرجى الانتظار",

      onPressed: isAvailable
          ? () {
              context.navigateTo(Routes.doctorDetailsScreen, arguments: doctor);
            }
          : null,

      width: double.infinity,
      height: 45.h,

      backgroundColor: isAvailable
          ? AppColors.primary
          : const Color(0xFFD9D9D9),

      textColor: isAvailable ? Colors.white : const Color(0xFF919191),

      elevation: 0,
      borderRadius: 10.r,

      textStyle: AppTypography.bodyLarge.copyWith(
        color: isAvailable ? Colors.white : const Color(0xFF919191),
      ),
    );
  }
}
