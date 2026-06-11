import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/data/models/verify_otp_request.dart';
import 'package:rafiq/features/authentication/presentation/bloc/authentication_cubit.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_footer_text.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

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

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5.w),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.error, width: 1.5.w),
      ),
    );

    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          UiUtils.showLoading(context);
        }

        if (state is VerifyResetOtpSuccess) {
          UiUtils.hideDialog(context);

          context.navigateTo(
            Routes.resetPass,
            arguments: {
              'email': widget.email,
              'otp': _pinController.text.trim(),
            },
          );
        }

        if (state is AuthenticationError) {
          UiUtils.hideDialog(context);

          UiUtils.showMessage(
            message: state.message,
            bgColor: Colors.red,
            fgColor: Colors.white,
          );
        }
      },

      child: Scaffold(
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
                        fontSize: 32.sp,
                      ),
                    ),

                    const HeightSpace(20),

                    Text(
                      'لقد أرسلنا رمز تحقق مكون من 4 أرقام\nإلى بريدك الإلكتروني',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLarge,
                    ),

                    const HeightSpace(32),

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
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          separatorBuilder: (_) => SizedBox(width: 12.w),
                          validator: (value) {
                            if (value == null || value.length < 4) {
                              return 'الرمز غير مكتمل';
                            }
                            return null;
                          },
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          errorTextStyle: const TextStyle(
                            height: 0,
                            fontSize: 0,
                          ),
                        ),
                      ),
                    ),

                    const HeightSpace(40),

                    CustomButton(
                      text: 'تحقق',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthenticationCubit>().verifyResetOtp(
                            request: VerifyResetOtpRequest(
                              email: widget.email,
                              otp: _pinController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),

                    const HeightSpace(24),

                    CustomFooterText(
                      textTitel: 'لم يصلك الرمز؟ ',
                      linkTitel: 'إعادة إرسال رمز التحقق',
                      onTap: () {
                        // context.read<AuthenticationCubit>().resendOtp(
                        //   ResendOtpRequest(email: widget.email),
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
