import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class DoctorAppointmentAppBar extends StatelessWidget {
  final String doctorName;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onAvatarTap;

  const DoctorAppointmentAppBar({
    super.key,
    required this.doctorName,
    this.onNotificationTap,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onAvatarTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDBEAFE),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.primary,
                    size: 26.sp,
                  ),
                ),
                const WidthSpace(8),
                SizedBox(
                  width: 180.w,
                  child: Text(
                    doctorName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodymid.copyWith(
                      color: AppColors.selectedText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // زر التنبيهات
          GestureDetector(
            onTap: onNotificationTap,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 28.w,
              height: 28.h,
              child: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textSecondary,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}