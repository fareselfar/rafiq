import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/assets_manger.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 410.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(SvgManger.success),
            HeightSpace(8),
            Text("تم تحديث البيانات بنجاح", style: AppTypography.dialogTitle),
            HeightSpace(40),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 180.w,
                child: CustomButton(
                  text: "المتابعة",
                  onPressed: () {
                    context.goBack();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
