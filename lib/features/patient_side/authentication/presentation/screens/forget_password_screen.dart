import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/send_otp_request.dart';
import 'package:rafiq/features/patient_side/authentication/presentation/bloc/authentication_cubit.dart';

class ForgetPassword extends StatefulWidget {
  final String? email;
  const ForgetPassword({super.key, this.email});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPassword> {
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // وضع الإيميل القادم في الـ Controller فوراً عند فتح الصفحة
    emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SendResetOtpSuccess) {
          context.navigateTo(
            Routes.otpScreen,
            arguments: emailController.text.trim(),
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
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نسيت كلمة المرور؟',
                    style: AppTypography.primaryHeadLinesStyle.copyWith(
                      fontSize: 38.sp,
                      height: 1.2,
                    ),
                  ),

                  HeightSpace(20),
                  Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      'اكتب بريدك الإلكتروني وسنساعدك في إعادة \nتعيين كلمة المرور',
                      style: AppTypography.subTitelStyle.copyWith(
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HeightSpace(20),

                  CustomTextField(
                    label: 'البريد الإلكتروني',
                    controller: emailController,
                    hint: 'example@mail.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: Validators.combine([
                      (value) => Validators.required(
                        value,
                        fieldName: 'البريد الإلكتروني',
                      ),
                      (value) => Validators.email(value),
                    ]),
                    inputStyle: AppTypography.inputTextFormStyle,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  HeightSpace(20),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final cubit = BlocProvider.of<AuthenticationCubit>(
                            context,
                          );

                          cubit.sendResetOtp(
                            request: SendResetOtpRequest(
                              email: emailController.text.trim(),
                            ),
                          );
                        }
                      },
                      text: 'التالي',
                    ),
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
