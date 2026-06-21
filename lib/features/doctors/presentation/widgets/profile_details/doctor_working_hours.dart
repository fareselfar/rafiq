import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class DoctorWorkingHours extends StatelessWidget {
  final List<WeeklyScheduleEntity> schedule;

  const DoctorWorkingHours({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    if (schedule.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text('مواعيد العمل', style: AppTypography.doctorName),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: schedule.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.dayName,
                      style: AppTypography.profileServiceDetailsStyle,
                    ),
                    Text(
                      item.isClosed ? 'مغلق' : item.timeRange,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: item.isClosed ? Colors.red : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}