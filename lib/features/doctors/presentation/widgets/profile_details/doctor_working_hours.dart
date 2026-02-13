import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/doctors/domain/entities/working_hours.dart';

class DoctorWorkingHours extends StatelessWidget {
  final List<WorkingHours> workingHours;

  const DoctorWorkingHours({super.key, required this.workingHours});

  @override
  Widget build(BuildContext context) {
    if (workingHours.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مواعيد العمل', style: AppTypography.doctorName),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: workingHours
                .map(
                  (item) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.day,
                          style: AppTypography.profileServiceDetailsStyle,
                        ),
                        Text(
                          item.time,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: item.isClosed
                                ? Colors.red
                                : AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
