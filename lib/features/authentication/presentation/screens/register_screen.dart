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
import 'package:rafiq/features/authentication/data/models/register_request.dart';
import 'package:rafiq/features/authentication/presentation/bloc/authentication_cubit.dart';
import 'package:rafiq/features/authentication/presentation/widgets/custom_footer_text.dart';
import 'package:rafiq/features/patient_profile/edit_profile/presentation/widgets/gender_item.dart';

// ─── خريطة التخصصات: العربي (للعرض) → الإنجليزي (للـ API) ───────────────────
const Map<String, String> _specializationsMap = {
  'طب الأسنان': 'Dentistry',
  'الطب الباطني': 'Internal Medicine',
  'طب الأطفال': 'Pediatrics',
  'أمراض القلب': 'Cardiology',
  'الأنف والأذن والحنجرة': 'ENT',
  'طب العيون': 'Ophthalmology',
  'أمراض النساء والتوليد': 'Obstetrics and Gynecology',
  'الأمراض الجلدية': 'Dermatology',
};

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserType userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  String selectedGender = 'male';

  /// التخصص المختار بالعربي (للعرض في الـ DropdownButton)
  String? _selectedSpecializationAr;

  bool get _isDoctor => widget.userType == UserType.doctor;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _handleState,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ─── Header ────────────────────────────────────────────
                  Text(
                    'أهلاً بك!\nلنبدأ رحلتك معنا',
                    style: AppTypography.primaryHeadLinesStyle,
                  ),
                  Padding(
                    padding: REdgeInsets.only(right: 16),
                    child: Text(
                      'أدخل بياناتك الشخصية${_isDoctor ? ' والمهنية ' : ' '}للانضمام إلى منصتنا',
                      style: AppTypography.subTitelStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HeightSpace(16),

                  // ─── Card ───────────────────────────────────────────────
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
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Section title ──────────────────────────────
                          Text(
                            'المعلومات الشخصية',
                            style: AppTypography.subTitelStyle,
                          ),
                          HeightSpace(16),

                          // ── Name ───────────────────────────────────────
                          CustomTextField(
                            label: 'الاسم بالكامل',
                            hint: 'مثال: محمد علي عبد العزيز',
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'من فضلك أدخل الاسم'
                                : null,
                          ),
                          HeightSpace(18),

                          // ── Email ──────────────────────────────────────
                          CustomTextField(
                            label: 'البريد الإلكتروني',
                            hint: 'example@mail.com',
                            controller: _emailController,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => Validators.email(v),
                          ),
                          HeightSpace(18),

                          // ── Phone ──────────────────────────────────────
                          CustomTextField(
                            label: 'رقم الهاتف',
                            hint: '+20 0XX XXXXX XXX',
                            textDirection: TextDirection.ltr,
                            controller: _phoneController,
                            autofillHints: const [
                              AutofillHints.telephoneNumber,
                            ],
                            textInputAction: TextInputAction.next,
                            validator: (v) => Validators.phone(v),
                          ),
                          HeightSpace(18),

                          // ── Password ───────────────────────────────────
                          CustomTextField(
                            controller: _passwordController,
                            label: 'كلمة المرور',
                            hint: 'ادخل كلمة المرور',
                            isPassword: true,
                            prefixIcon: const Icon(Icons.lock),
                            iconColor: AppColors.primary,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (v) => Validators.password(v),
                          ),
                          HeightSpace(18),

                          // ── Confirm Password ───────────────────────────
                          CustomTextField(
                            isPassword: true,
                            controller: _rePasswordController,
                            label: 'تأكيد كلمة المرور',
                            hint: '*************',
                            prefixIcon: const Icon(Icons.lock),
                            iconColor: AppColors.primary,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (v) => Validators.confirmPassword(
                              _passwordController.text,
                              v,
                            ),
                          ),
                          HeightSpace(18),
                          Row(
                            children: [
                              Expanded(
                                child: GenderItem(
                                  title: "ذكر",
                                  icon: Icons.male,
                                  selectedGender: selectedGender,
                                  value: "male",
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'male';
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: GenderItem(
                                  title: "أنثى",
                                  icon: Icons.female,
                                  value: "female",
                                  onTap: () {
                                    setState(() {
                                      selectedGender = 'female';
                                    });
                                  },
                                  selectedGender: selectedGender,
                                ),
                              ),
                            ],
                          ),
                          HeightSpace(18),
                          // ── Specialization (Doctor only) ───────────────
                          if (_isDoctor) ...[
                            Text(
                              'التخصص الطبي',
                              style: AppTypography.subTitelStyle,
                            ),
                            HeightSpace(8),
                            _SpecializationDropdown(
                              specializations: _specializationsMap.keys
                                  .toList(),
                              selectedValue: _selectedSpecializationAr,
                              onChanged: (val) => setState(
                                () => _selectedSpecializationAr = val,
                              ),
                            ),
                            HeightSpace(18),
                          ],

                          // ── Submit button ──────────────────────────────
                          Align(
                            alignment: Alignment.center,
                            child: CustomButton(
                              text: 'سجل الآن',
                              onPressed: _onRegister,
                            ),
                          ),
                          HeightSpace(16),

                          // ── Footer ─────────────────────────────────────
                          CustomFooterText(
                            textTitel: 'لديك حساب بالفعل؟ ',
                            onTap: () => context.navigateAndReplace(
                              '/login',
                              arguments: widget.userType,
                            ),
                            linkTitel: 'سجّل دخولك الآن',
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

  // ─── Listener ────────────────────────────────────────────────────────────────
  void _handleState(BuildContext context, AuthenticationState state) {
    if (state is AuthenticationLoading) {
      UiUtils.showLoading(context);
      return;
    }

    // أخفي الـ loading في كل الحالات التانية

    if (state is RegisterSuccess) {
      UiUtils.hideDialog(context);

      UiUtils.showMessage(
        message: "تم إنشاء الحساب بنجاح",
        bgColor: Colors.green,
        fgColor: Colors.white,
      );
      // بعد التسجيل الناجح → روح لصفحة الـ OTP أو الـ Home حسب تصميمك
      // حالياً بنوجه لصفحة الـ OTP (السيرفر بيبعت OTP تلقائياً عند التسجيل)
      context.navigateAndReplace('/login', arguments: widget.userType);
      // لو عايز تروح مباشرة للـ Home بعد التحقق من الـ OTP،
      // اعمل التوجيه ده في شاشة الـ OTP بناءً على الـ role المحفوظ في SharedPrefs
    }

    if (state is AuthenticationError) {
      UiUtils.hideDialog(context);
      UiUtils.showMessage(
        message: state.message,
        bgColor: Colors.red,
        fgColor: Colors.white,
      );
    }
  }

  // ─── Register logic ───────────────────────────────────────────────────────────
  void _onRegister() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // تحقق من التخصص لو طبيب
    if (_isDoctor && _selectedSpecializationAr == null) {
      UiUtils.showMessage(
        message: 'من فضلك اختر التخصص الطبي أولاً',
        bgColor: Colors.orange,
        fgColor: Colors.white,
      );
      return;
    }

    // تحويل التخصص من عربي → إنجليزي قبل الإرسال للـ API
    final specializationEn = _isDoctor
        ? _specializationsMap[_selectedSpecializationAr]
        : null;

    final request = RegisterRequest(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      role: _isDoctor ? 'Doctor' : 'Patient',
      specialization: specializationEn,
      gender: selectedGender,
    );

    context.read<AuthenticationCubit>().register(request);
  }
}

// ─── Dropdown Widget ──────────────────────────────────────────────────────────
class _SpecializationDropdown extends StatelessWidget {
  const _SpecializationDropdown({
    required this.specializations,
    required this.selectedValue,
    required this.onChanged,
  });

  final List<String> specializations;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      hint: Text(
        'اختر تخصصك الطبي',
        style: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
      ),
      items: specializations
          .map(
            (spec) => DropdownMenuItem<String>(
              value: spec,
              child: Text(
                spec,
                style: TextStyle(fontSize: 14.sp),
                textDirection: TextDirection.rtl,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: (_) => null, // التحقق بيتم يدوياً في الـ _onRegister
    );
  }
}
