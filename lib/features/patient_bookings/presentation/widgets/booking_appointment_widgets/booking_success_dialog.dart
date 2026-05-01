import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class BookingSuccessDialog extends StatelessWidget {
  const BookingSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min, // عشان مياخدش الشاشة كلها
          children: [
            Icon(Icons.check_circle, size: 80.sp, color: Colors.green),
            const HeightSpace(16),
            Text(
              "تم إعادة الجدولة بنجاح!",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            const HeightSpace(8),
            const Text(
              "تم تحديث موعد حجزك بنجاح.",
              textAlign: TextAlign.center,
            ),
            const HeightSpace(24),
            CustomButton(
              text: "العودة للرئيسية",
              onPressed: () => context.navigateAndRemoveUntil("/home"),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
