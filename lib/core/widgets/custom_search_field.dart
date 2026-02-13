import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class CustomSearchField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  final Widget? suffixIcon;

  const CustomSearchField({
    super.key,
    this.hint = "بحث...",
    this.controller,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,

      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),

      style: AppTypography.inputTextFormStyle,

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.inputHint,

        prefixIcon: const Icon(Icons.search),

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: AppColors.surface,

        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
