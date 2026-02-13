import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class DoctorLocation extends StatelessWidget {
  final String address;

  const DoctorLocation({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.textSecondary,
          size: 18.sp,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            address,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, 
          ),
        ),
      ],
    );
  }
}
