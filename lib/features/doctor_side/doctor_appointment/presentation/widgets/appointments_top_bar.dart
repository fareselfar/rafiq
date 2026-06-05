// lib/features/doctor_side/doctor_appointments/presentation/widgets/appointments_top_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';

class AppointmentsTopBar extends StatelessWidget {
  final VoidCallback? onAddAppointment;

  const AppointmentsTopBar({super.key, this.onAddAppointment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _AppointmentsTitle(),
          const Spacer(),
          _AddAppointmentButton(onPressed: onAddAppointment),
        ],
      ),
    );
  }
}

class _AppointmentsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'مواعيد الأسبوع',
      style: AppTypography.profileServicesStyle,
    );
  }
}

class _AddAppointmentButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _AddAppointmentButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'إضافة موعد مثاق',
      onPressed: onPressed,
      type: ButtonType.filled,
      width: 140.w,
      height: 36.h,
      backgroundColor: AppColors.primary,
      borderRadius: 20,
      elevation: 0,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
