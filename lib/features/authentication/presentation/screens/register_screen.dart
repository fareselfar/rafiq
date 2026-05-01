import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_footer_text.dart';

class RegisterScreen extends StatefulWidget {
  final UserType? userType;
  const RegisterScreen({super.key, this.userType});

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

  String? selectedSpecialization;
  final List<String> specializations = [
    'قلب',
    'عظام',
    'أطفال',
    'جلدية',
    'نفسي',
  ];

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
                    "أدخل بياناتك الشخصية والمهنية للانضمام إلى منصتنا",
                    style: AppTypography.subTitelStyle,
                    textAlign: TextAlign.center,
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
                          autofillHints: const [AutofillHints.telephoneNumber],
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

                        if (widget.userType == UserType.doctor) ...[
                          const HeightSpace(18),
                          Text(
                            'المعلومات المهنية',
                            style: AppTypography.subTitelStyle,
                          ),
                          const HeightSpace(10),
                          Container(
                            padding: REdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedSpecialization,
                                isExpanded: true,
                                hint: Text(
                                  "اختر التخصص الطبي",
                                  style: AppTypography.subTitelStyle.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                dropdownColor: Colors.white,
                                items: specializations
                                    .map(
                                      (spec) => DropdownMenuItem(
                                        value: spec,
                                        child: Text(
                                          spec,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    selectedSpecialization = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
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
    );
  }

  void _register() {
    if (formKey.currentState?.validate() == true) {
      // التأكد من اختيار التخصص في حالة الطبيب
      if (widget.userType == UserType.doctor &&
          selectedSpecialization == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("من فضلك اختر التخصص الطبي أولاً")),
        );
        return;
      }

      // --- ملاحظة: هنا المفروض يتم استدعاء الـ API عبر الـ Cubit ---
      // context.read<RegisterCubit>().registerDoctor/Patient(...)

      // بعد نجاح الـ Request، هنوجه المستخدم بناءً على نوعه:
      if (widget.userType == UserType.doctor) {
        // التوجه لصفحة الدكتور الرئيسية (مع مسح الـ stack)
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.doctorHome,
          (route) => false,
        );
      } else {
        // التوجه لصفحة المريض الرئيسية (مع مسح الـ stack)
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.patientHome,
          (route) => false,
        );
      }
    }
  }
}
