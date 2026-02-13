import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class DoctorRating extends StatelessWidget {
  final double rating;

  const DoctorRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.warning, size: 18.sp),
        HeightSpace(8),
        Text(rating.toString(), style: AppTypography.bodySmall),
      ],
    );
  }
}
