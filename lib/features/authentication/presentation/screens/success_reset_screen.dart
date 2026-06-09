import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';

class SuccessResetScreen extends StatelessWidget {
  const SuccessResetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.goBack(),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تمت إعادة تعيين \n كلمة المرور بنجاح',
                style: AppTypography.primaryHeadLinesStyle.copyWith(
                  fontSize: 38.sp,
                  height: 1.2,
                ),
              ),

              HeightSpace(20),
              Align(
                alignment: Alignment.centerRight,

                child: Text(
                  ' تم تحديث كلمة المرور الخاصة بك بنجاح.\nيمكنك الآن تسجيل الدخول باستخدام كلمة\nالمرور الجديدة.',
                  style: AppTypography.subTitelStyle.copyWith(fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              HeightSpace(20),

              HeightSpace(20),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  onPressed: () async {
                    final role = await AuthSharedPrefs().getRole();

                    print('SAVED ROLE => $role');

                    if (role.isEmpty) {
                      context.navigateAndReplace(Routes.login);
                      return;
                    }

                    if (role.trim() == 'Doctor') {
                      context.navigateAndReplace(Routes.docLogin);
                    } else {
                      context.navigateAndReplace(Routes.login);
                    }
                  },
                  text: 'العودة إلى تسجيل الدخول',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
