import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class NoticeBox extends StatelessWidget {
  const NoticeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),

      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4.r,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          right: BorderSide(color: AppColors.primary, width: 1.5.w),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 5.h),
            child: Icon(
              Icons.info_outline,
              color: AppColors.primary,
              size: 30.sp,
            ),
          ),
          const WidthSpace(10),
          Expanded(
            child: Text(
              'لضمان موعدك بالكامل:\n ننصح بالدفع الإلكتروني لتأكيد الحجز. الحجوزات بالدفع عند الوصول قد تتأثر بأولوية المواعيد المؤكدة.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.hintStyle,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
