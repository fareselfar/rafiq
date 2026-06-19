// presentation/widgets/success_widgets/success_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class SuccessActions extends StatelessWidget {
  const SuccessActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: "الانتقال الى حجوزاتي",
              onPressed: () {
                context.navigateAndRemoveUntil(
                  Routes.patientHome,
                  arguments: 3,
                );
              },
              width: double.infinity,
            ),
            const HeightSpace(12),
            CustomButton(
              text: "العودة الى الرئيسية",
              onPressed: () {
                context.navigateAndRemoveUntil("/patienthome");
              },
              type: ButtonType.outlined,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
