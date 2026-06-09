import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/presentation/bloc/authentication_cubit.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_divider.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_footer_text.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_inkwell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/authentication/data/models/login_request.dart';

class LoginDocScreen extends StatefulWidget {
  const LoginDocScreen({super.key});

  @override
  State<LoginDocScreen> createState() => _LoginDocScreenState();
}

class _LoginDocScreenState extends State<LoginDocScreen> {
  final formKey = GlobalKey<FormState>();
  bool _submitted = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          UiUtils.showLoading(context);
        }

        if (state is AuthenticationLoaded) {
          UiUtils.hideDialog(context);
          UiUtils.showMessage(
            message: "تم تسجيل الدخول بنجاح",
            bgColor: Colors.green,
            fgColor: Colors.white,
          );
          context.pushReplacement('/home');
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'تسجيل الدخول',
                      style: AppTypography.primaryHeadLinesStyle,
                    ),

                    HeightSpace(20),

                    Text(
                      'سجّل دخولك وابدأ إدارة عملك الطبي بسهولة',
                      style: AppTypography.subTitelStyle,
                      textAlign: TextAlign.center,
                    ),

                    HeightSpace(20),

                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16.r),
                      ),

                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 32.h,
                        ),
                        child: Form(
                          key: formKey,
                          autovalidateMode: _submitted
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomTextField(
                                controller: emailController,
                                label: 'البريد الالكتروني او رقم الهاتف',
                                hint: 'ادخل البريد الالكتروني او رقم الهاتف',
                                inputStyle: AppTypography.inputTextFormStyle,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  size: 22.sp,
                                ),
                                //الاقتراح التلقائي من النظام
                                autofillHints: const [
                                  AutofillHints.email,
                                  AutofillHints.telephoneNumber,
                                ],
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,

                                validator: (value) =>
                                    Validators.emailOrPhone(value),
                              ),
                              HeightSpace(16),

                              CustomTextField(
                                controller: passwordController,
                                label: 'كلمة المرور',
                                hint: 'ادخل كلمة المرور',
                                inputStyle: AppTypography.inputTextFormStyle,
                                isPassword: true,

                                prefixIcon: const Icon(Icons.lock),
                                iconColor: AppColors.primary,

                                autofillHints: const [AutofillHints.password],
                                textInputAction: TextInputAction.done,

                                keyboardType: TextInputType.visiblePassword,
                                validator: (value) =>
                                    Validators.password(value),
                              ),
                              HeightSpace(8),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: CustomInkwell(
                                  onTap: () {
                                    context.navigateTo(
                                      '/forgetPassword',
                                      arguments: emailController.text,
                                    );
                                  },
                                  title: 'هل نسيت كلمة السر ؟',
                                ),
                              ),

                              HeightSpace(16),

                              CustomButton(
                                onPressed: () {
                                  setState(() => _submitted = true);
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthenticationCubit>().login(
                                      LoginRequest(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                                text: 'تسجيل الدخول',
                              ),

                              HeightSpace(16),
                              CustomDivider(title: 'او'),
                              HeightSpace(16),

                              CustomButton(
                                onPressed: () {},
                                type: ButtonType.outlined,
                                text: "تسجيل الدخول بجوجل",
                                svgIconPath: 'assets/icons/icon_google.svg',
                              ),

                              HeightSpace(16),

                              CustomFooterText(
                                textTitel: 'مستخدم جديد؟ ',
                                onTap: () {
                                  context.navigateTo('/register');
                                },
                                linkTitel: "انشاء حساب الان",
                              ),
                            ],
                          ),
                        ),
                      ),
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
