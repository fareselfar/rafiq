import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class SuccessCancelDialog extends StatelessWidget {
  const SuccessCancelDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
      backgroundColor: AppColors.backGround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.primary,
              size: 80.sp,
            ),
            const HeightSpace(8),
            Text(
              "تم إلغاء الحجز بنجاح",
              style: AppTypography.dialogTitle.copyWith(
                color: AppColors.primary,
              ),
            ),
            const HeightSpace(10),
            Text(
              "نتمنى لك دوام الصحة والعافية",
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const HeightSpace(24),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: CustomButton(
                      text: "حجز موعد جديد",
                      onPressed: () {},
                    ),
                  ),
                ),
                WidthSpace(8),
                Expanded(
                  child: SizedBox(
                    child: CustomButton(
                      text: "عرض حجوزاتي",
                      type: ButtonType.outlined,
                      onPressed: () => Navigator.pop(context),
                    ),
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
