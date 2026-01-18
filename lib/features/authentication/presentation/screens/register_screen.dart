import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_fonts.dart';
import 'package:rafiq/core/widgets/password_visibility_icon.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _nameControler;
  late TextEditingController _emailControler;
  late TextEditingController _phoneControler;
  late TextEditingController _passwordControler;
  late TextEditingController _rePasswordControler;
  bool isPasswordHidden = true;
  bool isRePasswordHidden = true;

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
                  "!أهلاً بك",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontFamily: AppFonts.mainFontName,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'لنبدأ رحلتك معنا',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontFamily: AppFonts.mainFontName,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: REdgeInsets.only(right: 16),
                  child: Text(
                    'أدخل بياناتك الشخصية والمهنية',
                    style: GoogleFonts.cairo(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'للانضمام إلى منصتنا',
                    style: GoogleFonts.cairo(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
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
                          controller: _nameControler,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: 'البريد الالكتروني ',
                          hint: 'example@mail.com',
                          controller: _emailControler,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: 'رقم الهاتف',
                          hint: '+20 0XX XXXXX XXX',
                          textDirection: TextDirection.ltr,
                          controller: _phoneControler,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          obscureText: isPasswordHidden,
                          controller: _passwordControler,
                          label: 'كلمة المرور',
                          hint: '*************',
                          suffixIcon: PasswordVisibilityIcon(
                            isPasswordHidden: isPasswordHidden,
                            toggleVisibility: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },

                            iconColor: AppColors.textSecondary,
                          ),
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          obscureText: isRePasswordHidden,
                          controller: _rePasswordControler,
                          label: 'تأكيد كلمة المرور',
                          hint: '*************',
                          suffixIcon: PasswordVisibilityIcon(
                            isPasswordHidden: isRePasswordHidden,
                            toggleVisibility: () {
                              setState(() {
                                isRePasswordHidden = !isRePasswordHidden;
                              });
                            },

                            iconColor: AppColors.textSecondary,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'لديك حساب بالفعل؟',
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.selectedText,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                ' تسجيل الدخول',
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
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
