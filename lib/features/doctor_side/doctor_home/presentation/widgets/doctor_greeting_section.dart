// lib/features/doctor_side/doctor_home/presentation/widgets/doctor_greeting_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class DoctorGreetingSection extends StatelessWidget {
  final String doctorName;
  final int todayAppointmentsCount;

  const DoctorGreetingSection({
    super.key,
    required this.doctorName,
    required this.todayAppointmentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DoctorGreetingRichText(doctorName: doctorName),
          const HeightSpace(4),
          DoctorTodayCountText(count: todayAppointmentsCount),
        ],
      ),
    );
  }
}

class DoctorGreetingRichText extends StatelessWidget {
  final String doctorName;

  const DoctorGreetingRichText({super.key, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'أهلاً، بك ',
            style: AppTypography.homeTitle.copyWith(fontSize: 22.sp),
          ),
          TextSpan(
            text: 'دكتور $doctorName',
            style: AppTypography.homeSubTitle.copyWith(fontSize: 22.sp),
          ),
        ],
      ),
    );
  }
}

class DoctorTodayCountText extends StatelessWidget {
  final int count;

  const DoctorTodayCountText({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Text(
      'لديك $count مواعيد اليوم',
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
