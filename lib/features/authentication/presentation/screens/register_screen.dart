import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';
import 'package:rafiq/features/authentication/data/models/RegisterRequest.dart';
import 'package:rafiq/features/authentication/presentation/bloc/authentication_cubit.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_footer_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserType userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController phoneControler = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  @override
  void dispose() {
    namecontroller.dispose();
    emailControler.dispose();
    phoneControler.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          UiUtils.showLoading(context);
        }

        if (state is AuthenticationLoaded) {
          UiUtils.hideDialog(context);
          context.navigateAndReplace('/login');
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
        body: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "أهلاً بك!\nلنبدأ رحلتك معنا",
                    style: AppTypography.primaryHeadLinesStyle,
                  ),

                  Padding(
                    padding: REdgeInsets.only(right: 16),
                    child: Text(
                      "أدخل بياناتك الشخصية والمهنية للانضمام إلى منصتنا",
                      style: AppTypography.subTitelStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  HeightSpace(16),
                  Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 36,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20.r,
                          spreadRadius: 2.r,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المعلومات الشخصية',
                            style: AppTypography.subTitelStyle,
                          ),
                          HeightSpace(16),
                          CustomTextField(
                            label: 'الاسم بالكامل ',
                            hint: 'مثال:  محمد علي عبد العزيز',
                            controller: namecontroller,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [
                              AutofillHints.email,
                              AutofillHints.telephoneNumber,
                            ],
                          ),
                          HeightSpace(18),
                          CustomTextField(
                            label: 'البريد الالكتروني ',
                            hint: 'example@mail.com',
                            controller: emailControler,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => Validators.email(value),
                          ),
                          HeightSpace(18),
                          CustomTextField(
                            label: 'رقم الهاتف',
                            hint: '+20 0XX XXXXX XXX',
                            textDirection: TextDirection.ltr,
                            controller: phoneControler,
                            autofillHints: const [
                              AutofillHints.telephoneNumber,
                            ],
                            textInputAction: TextInputAction.next,
                            validator: (value) => Validators.phone(value),
                          ),
                          HeightSpace(18),
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
                            validator: (value) => Validators.password(value),
                          ),
                          HeightSpace(18),
                          CustomTextField(
                            isPassword: true,
                            controller: rePasswordController,
                            label: 'تأكيد كلمة المرور',
                            hint: '*************',
                            prefixIcon: const Icon(Icons.lock),
                            iconColor: AppColors.primary,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) => Validators.confirmPassword(
                              passwordController.text,
                              value,
                            ),
                          ),

                          HeightSpace(16),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              child: CustomButton(
                                text: 'سجل الآن',
                                onPressed: _register,
                              ),
                            ),
                          ),

                          HeightSpace(16),
                          CustomFooterText(
                            textTitel: 'مستخدم جديد؟ ',
                            onTap: () {
                              context.navigateAndReplace('/login');
                            },
                            linkTitel: "انشاء حساب الان",
                          ),
                        ],
                      ),
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

  void _register() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    final request = RegisterRequest(
      name: namecontroller.text.trim(),
      email: emailControler.text.trim(),
      password: passwordController.text.trim(),
      role: widget.userType == UserType.doctor ? 'Doctor' : 'Patient',
    );
    context.read<AuthenticationCubit>().register(request);
  }
}
