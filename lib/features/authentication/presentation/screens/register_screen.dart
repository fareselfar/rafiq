import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_footer_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _rePasswordControler = TextEditingController();
  bool isPasswordHidden = true;
  bool isRePasswordHidden = true;
  @override
  @override
  void dispose() {
    _namecontroller.dispose();
    _emailControler.dispose();
    _phoneControler.dispose();
    _passwordControler.dispose();
    _rePasswordControler.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "أدخل بياناتك الشخصية والمهنية\n          للانضمام إلى منصتنا",
                    style: AppTypography.subTitelStyle,
                  ),
                ),

                HeightSpace(16),
                Container(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 36),

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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'المعلومات الشخصية',
                          style: GoogleFonts.cairo(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        HeightSpace(16),
                        CustomTextField(
                          label: 'الاسم بالكامل ',
                          hint: 'مثال:  محمد علي عبد العزيز',
                          controller: _namecontroller,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: 'البريد الالكتروني ',
                          hint: 'example@mail.com',
                          controller: _emailControler,
                          validator: (value) => Validators.email(value),
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: 'رقم الهاتف',
                          hint: '+20 0XX XXXXX XXX',
                          textDirection: TextDirection.ltr,
                          controller: _phoneControler,
                          validator: (value) => Validators.phone(value),
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          controller: _passwordControler,
                          label: 'كلمة المرور',
                          hint: '*************',
                          inputStyle: AppTypography.inputTextFormStyle,
                          isPassword: true,

                          iconColor: AppColors.textSecondary,

                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,

                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => Validators.password(value),
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          controller: _rePasswordControler,
                          label: 'تأكيد كلمة المرور',
                          hint: '*************',
                          inputStyle: AppTypography.inputTextFormStyle,
                          isPassword: true,

                          iconColor: AppColors.textSecondary,

                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,

                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => Validators.confirmPassword(
                            value,
                            _passwordControler.text,
                          ),
                        ),

                        HeightSpace(16),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 180.w,
                            child: CustomButton(
                              text: 'سجل الآن',
                              onPressed: _register,
                            ),
                          ),
                        ),

                        HeightSpace(16),
                        CustomFooterText(
                          textTitel: 'لديك حساب بالفعل؟',
                          onTap: () {
                            context.pushNamed(Routes.login);
                          },
                          linkTitel: ' تسجيل الدخول',
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
    );
  }

  void _register() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
}
