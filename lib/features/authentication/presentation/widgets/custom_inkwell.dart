import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class CustomInkwell extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final TextStyle? style;
  const CustomInkwell({
    super.key,
    required this.onTap,
    required this.title,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style:
            style ??
            AppTypography.bodymid.copyWith(
              color: AppColors.primary,
              //decoration: TextDecoration.underline,
            ),
      ),
    );
  }
}
