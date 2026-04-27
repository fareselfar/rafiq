import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.widget,
    this.horizontalPadding,
    this.verticalPadding,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.cardColor,
  });
  final Widget widget;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? width;
  final Color? borderColor;
  final double? borderWidth;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0,
        ),
        color: cardColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20.r,
            spreadRadius: 2.r,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 0,
        ),
        child: widget,
      ),
    );
  }
}
