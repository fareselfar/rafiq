import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class PrivacyNote extends StatelessWidget {
  const PrivacyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 38.h),
      decoration: BoxDecoration(
        color: AppColors.nots,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE58F).withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: Colors.orange, size: 22.sp),
              const WidthSpace(1.5),
              Text(
                "ملحوظة :",
                style: AppTypography.bodyLarge.copyWith(color: Colors.orange),
              ),
            ],
          ),
          const WidthSpace(12),
          Expanded(
            child: Text(
              "ردود الذكاء الاصطناعي للإرشاد فقط، ولا تغني عن استشارة الطبيب المختص لسلامتك",
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
