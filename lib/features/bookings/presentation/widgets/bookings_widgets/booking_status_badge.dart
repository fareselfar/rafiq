import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/enums/booking__status.dart';

class BookingStatusBadge extends StatelessWidget {
  final BookingStatus status;
  const BookingStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color background;
    Color text;
    String label;

    switch (status) {
      case BookingStatus.upcoming:
        background = AppColors.lightBlue;
        text = AppColors.primary;
        label = "قادم";
        break;
      case BookingStatus.completed:
        background = AppColors.greenWhite;
        text = AppColors.success;
        label = "مكتمل";
        break;
      default:
        background = AppColors.redWhite;
        text = AppColors.error;
        label = "ملغي";
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall.copyWith(color: text, fontSize: 12.sp),
      ),
    );
  }
}
