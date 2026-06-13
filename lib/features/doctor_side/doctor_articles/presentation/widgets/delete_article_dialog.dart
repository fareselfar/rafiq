import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class DeleteArticleDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteArticleDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.red, size: 52.sp),
            const HeightSpace(16),
            Text(
              'هل انت متاكد من حذف هذا المقال',
              textAlign: TextAlign.center,
              style: AppTypography.dialogTitle.copyWith(fontSize: 16.sp),
            ),
            const HeightSpace(24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'رجوع',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const WidthSpace(12),
                Expanded(
                  child: CustomButton(
                    text: 'حذف',
                    type: ButtonType.outlined,
                    borderColor: AppColors.red,
                    textColor: AppColors.red,
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
