import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_fonts.dart';

/// Application Typography
/// Centralized text style definitions
class AppTypography {
  // Private constructor to prevent instantiation
  static final String _fontFamily = AppFonts.mainFontName;
  static final String _secondaryFontFamily = AppFonts.secondaryFontName;

  // Heading Styles
  static TextStyle primaryHeadLinesStyle = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle subTitelStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.5.h,
    color: AppColors.textSecondary,
  );

  // Body Text Styles
  static TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle bodymid = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  // Button Text Style
  static TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
  );

  // Label Text Styles
  static TextStyle inputLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textLabel,
  );
  static TextStyle inputTextFormStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.inputTextFormStyle,
  );

  static TextStyle inputHint = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textDisabled,
  );
  static TextStyle appBarTitelStyle = TextStyle(
    fontFamily: _secondaryFontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.selectedText,
  );
  static TextStyle profileNameStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textLabel,
  );
  static TextStyle profileRoleStyle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,

  static TextStyle bubbleMessage = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.5.h,
  );
}
