import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

enum DoctorFilter { nearest, topRated, availableToday }

class FilterChipsSection extends StatelessWidget {
  final DoctorFilter selectedFilter;
  final ValueChanged<DoctorFilter> onFilterChanged;

  const FilterChipsSection({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  static const _labels = {
    DoctorFilter.nearest: 'الأقرب',
    DoctorFilter.topRated: 'الأعلى تقييماً',
    DoctorFilter.availableToday: 'المتاح اليوم',
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: DoctorFilter.values.length,
        separatorBuilder: (context, index) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final filter = DoctorFilter.values[index];
          final isSelected = selectedFilter == filter;

          return GestureDetector(
            onTap: () => onFilterChanged(filter),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected ? AppColors.primary : const Color(0xFFE0E0E0),
                ),
              ),
              child: Center(
                child: Text(
                  _labels[filter]!,
                  style: AppTypography.bodySmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}