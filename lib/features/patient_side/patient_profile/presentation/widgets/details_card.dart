import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/card_widget.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      verticalPadding: 8.r,
      width: 86.w,
      borderColor: AppColors.primary,
      borderWidth: 1,
      widget: Column(
        children: [
          Text(title, style: AppTypography.bodymid),
          HeightSpace(16),
          Text(value, style: AppTypography.inputLabel),
        ],
      ),
    );
  }
}
