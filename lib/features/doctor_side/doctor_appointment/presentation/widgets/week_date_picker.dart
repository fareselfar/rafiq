// lib/features/doctor_side/doctor_appointments/presentation/widgets/week_date_picker.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class WeekDatePicker extends StatelessWidget {
  final DateTime windowStart;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  static const int windowSize = 9;

  const WeekDatePicker({
    super.key,
    required this.windowStart,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MonthYearLabel(windowStart: windowStart),
        const HeightSpace(10),
        _DaysStrip(
          windowStart: windowStart,
          selectedDay: selectedDay,
          onDaySelected: onDaySelected,
        ),
      ],
    );
  }
}

class _MonthYearLabel extends StatelessWidget {
  final DateTime windowStart;
  const _MonthYearLabel({required this.windowStart});

  static const _months = [
    '',
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        '${_months[windowStart.month]} ${windowStart.year}',
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}

class _DaysStrip extends StatefulWidget {
  final DateTime windowStart;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDaySelected;

  const _DaysStrip({
    required this.windowStart,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  State<_DaysStrip> createState() => _DaysStripState();
}

class _DaysStripState extends State<_DaysStrip> {
  final ScrollController _controller = ScrollController();

  static const _dayNames = [
    '', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: WeekDatePicker.windowSize,
        separatorBuilder: (_, _) => SizedBox(width: 12.w),
        itemBuilder: (context, i) {
          final day = widget.windowStart.add(Duration(days: i));

          final isSelected = day.year == widget.selectedDay.year &&
              day.month == widget.selectedDay.month &&
              day.day == widget.selectedDay.day;

          return _DayCardCell(
            day: day,
            dayName: _dayNames[day.weekday],
            isSelected: isSelected,
            onTap: () => widget.onDaySelected(day),
          );
        },
      ),
    );
  }
}

class _DayCardCell extends StatelessWidget {
  final DateTime day;
  final String dayName;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayCardCell({
    required this.day,
    required this.dayName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65.w,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade100,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: AppTypography.bodySmall.copyWith(
                color: isSelected ? AppColors.surface : AppColors.textSecondary,
                fontSize: 12.sp,
              ),
            ),
            const HeightSpace(4),
            Text(
              day.day.toString(),
              style: AppTypography.doctorName.copyWith(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}