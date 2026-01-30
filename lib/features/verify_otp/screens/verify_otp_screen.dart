import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_footer_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: AppTypography.primaryHeadLinesStyle.copyWith(
        fontSize: 22.sp,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(width: 1.w, color: AppColors.border),
      ),
    );

    // 2. ثيم التركيز (Focused) - شاشة OTP2 و OTP4
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: AppColors.primary, // اللون الأزرق في التصميم
          width: 1.5.w, // زيادة بسيطة للتمييز
        ),
      ),
    );

    // 3. ثيم الخطأ (Error) - شاشة OTP5
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(
          color: AppColors.error, // اللون الأحمر في OTP5
          width: 1.5.w,
        ),
      ),
    );

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
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'أدخل رمز التحقق',
                    style: AppTypography.primaryHeadLinesStyle.copyWith(
                      fontSize: 40.sp,
                    ),
                  ),

                  HeightSpace(20),

                  Text(
                    'لقد أرسلنا رمز تحقق مكون من 4 أرقام\nإلى بريدك الإلكتروني',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge,
                  ),

                  HeightSpace(20),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Form(
                      key: _formKey,
                      child: Pinput(
                        length: 4,
                        controller: _pinController,
                        defaultPinTheme: defaultPinTheme,

                        focusedPinTheme: focusedPinTheme,
                        errorPinTheme: errorPinTheme,
                        separatorBuilder: (_) => SizedBox(width: 12.w),
                        validator: (value) =>
                            value!.length == 4 ? null : 'أدخل الرمز كامل',
                        errorTextStyle: const TextStyle(height: 0, fontSize: 0),
                      ),
                    ),
                  ),

                  HeightSpace(20),

                  CustomButton(
                    text: 'تحقق',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        debugPrint('OTP: ${_pinController.text}');
                      }
                    },
                  ),

                  HeightSpace(20),

                  CustomFooterText(
                    textTitel: 'لم يصلك الرمز؟ ',
                    linkTitel: 'إعادة إرسال رمز التحقق',
                    onTap: () {
                      debugPrint('إعادة إرسال الرمز');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
