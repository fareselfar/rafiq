import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';

class GradientCard extends StatelessWidget {
  GradientCard({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [AppColors.darkBlue, AppColors.blue],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: child,
    );
  }
}
