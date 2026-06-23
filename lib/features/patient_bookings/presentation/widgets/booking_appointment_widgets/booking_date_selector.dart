// lib/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_date_selector.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class BookingDateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const BookingDateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  String _getDayName(int weekday) {
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: 7,
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          // ← بدأنا من النهارده (index 0 = اليوم)
          final date = DateTime.now().add(Duration(days: index));
          final isSelected =
              date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 65.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColors.primary.withOpacity(0.3)
                        : Colors.black.withOpacity(0.02),
                    blurRadius: isSelected ? 10 : 4,
                    spreadRadius: isSelected ? 1 : 0,
                    offset: Offset(0, isSelected ? 6 : 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(date.weekday),
                    style: AppTypography.bodySmall.copyWith(
                      color: isSelected
                          ? AppColors.surface
                          : AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                  const HeightSpace(4),
                  Text(
                    date.day.toString(),
                    style: AppTypography.doctorName.copyWith(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
