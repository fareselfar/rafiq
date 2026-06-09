import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class BookingSelectionHeader extends StatelessWidget {
  final DateTime selectedDate;

  const BookingSelectionHeader({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'اختر التاريخ',
          style: AppTypography.doctorName.copyWith(fontSize: 16.sp),
        ),
        Text(
          DateFormat('MMMM yyyy', 'ar').format(selectedDate),
          style: AppTypography.bodymid.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
