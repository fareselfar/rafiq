import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';

class SuccessActions extends StatelessWidget {
  const SuccessActions({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SafeArea(
      top: false,

      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 18.h),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 20,
              offset: const Offset(0, -6),
            ),
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: "الانتقال الى حجوزاتي",
              onPressed: () {
                context.navigateAndRemoveUntil("/bookingsScreen");
              },
              width: size.width,
            ),

            const HeightSpace(12),

            CustomButton(
              text: "العودة الى الرئيسية",
              onPressed: () {
                context.navigateAndRemoveUntil("/home");
              },
              type: ButtonType.outlined,
              width: size.width,
            ),
          ],
        ),
      ),
    );
  }
}
