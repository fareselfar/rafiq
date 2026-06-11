import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/patient_side/authentication/presentation/widgets/custom_inkwell.dart';

class CustomFooterText extends StatelessWidget {
  final void Function()? onTap;
  final String textTitel;
  final String linkTitel;
  const CustomFooterText({
    super.key,
    required this.textTitel,
    required this.onTap,
    required this.linkTitel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textTitel,
          style: AppTypography.bodymid.copyWith(color: AppColors.textSecondary),
        ),
        CustomInkwell(onTap: onTap, title: linkTitel),
      ],
    );
  }
}
