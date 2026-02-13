import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/success_cancel_dialog.dart';

class CancelBookingDialog extends StatelessWidget {
  const CancelBookingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
      backgroundColor: AppColors.backGround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(vertical: 49.h, horizontal: 30.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 64.sp,
              color: AppColors.red,
            ),
            Text(
              "هل أنت متأكد أنك تريد إلغاء هذا الحجز؟",
              textAlign: TextAlign.center,
              style: AppTypography.dialogTitle.copyWith(
                color: AppColors.red,
                fontSize: 24.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "لن تتمكن من استرجاعه بعد الإلغاء.",
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge,
            ),
            HeightSpace(40),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: CustomButton(
                      text: "تأكيد الإلغاء",
                      type: ButtonType.outlined,
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (_) => const SuccessCancelDialog(),
                        );
                      },
                    ),
                  ),
                ),
                WidthSpace(8),
                Expanded(
                  child: SizedBox(
                    child: CustomButton(
                      text: "رجوع",
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
