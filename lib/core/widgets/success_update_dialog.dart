import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class SuccessUpdateDialog extends StatelessWidget {
  const SuccessUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: AppColors.backGround, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.5),
                  width: 2.w,
                ),
              ),
              child: Icon(
                Icons.check_rounded,
                color: AppColors.primary,
                size: 50.sp,
              ),
            ),
            const HeightSpace(24),
            Text(
              "تم تحديث الموعد بنجاح",
              style: AppTypography.dialogTitle.copyWith(
                color: AppColors.primary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const HeightSpace(32),
            CustomButton(
              text: "المتابعة",
              onPressed: () {
                context.navigateAndRemoveUntil(Routes.home, arguments: 3);
              },
            ),
          ],
        ),
      ),
    );
  }
}