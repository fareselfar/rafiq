import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/onbording/models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel model;
  const OnboardingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        //image
        SizedBox(
          height: 375.h,
          width: size.width,
          child: Image.asset(model.imagePath, fit: BoxFit.contain),
        ),

        //title and description
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: AppTypography.primaryHeadLinesStyle,
        ),
        const HeightSpace(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            model.description,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
