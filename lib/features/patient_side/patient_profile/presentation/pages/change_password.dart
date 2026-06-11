import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/authentication/presentation/widgets/custom_inkwell.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/card_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تغيير كلمة المرور", style: AppTypography.appBarTitelStyle),
      ),
      body: Padding(
        padding: REdgeInsets.only(left: 16, top: 19, bottom: 49, right: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: passwordController,
                label: 'كلمة المرور',
                hint: '**************',
                inputStyle: AppTypography.inputTextFormStyle,
                isPassword: true,

                autofillHints: const [AutofillHints.password],
                textInputAction: TextInputAction.done,

                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validators.password(value),
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
              HeightSpace(24),
              CustomTextField(
                controller: newPasswordController,
                label: 'كلمة المرور الجديدة',
                hint: '**************',
                inputStyle: AppTypography.inputTextFormStyle,
                isPassword: true,

                autofillHints: const [AutofillHints.password],
                textInputAction: TextInputAction.done,

                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validators.password(value),
              ),
              HeightSpace(24),
              CardWidget(
                cardColor: AppColors.note,
                borderColor: AppColors.info,
                borderWidth: 2,
                widget: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 19),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.info,
                        size: 40.sp,
                      ),
                      WidthSpace(20),
                      Text(
                        "8احرف على الاقل\n حرف كبير واحد على الاقل (A-Z)\n رقم واحد على الاقل (0-9)",
                        style: AppTypography.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              HeightSpace(24),
              CustomTextField(
                controller: confirmNewPasswordController,
                label: 'تأكيد كلمة المرور',
                hint: '**************',
                inputStyle: AppTypography.inputTextFormStyle,
                isPassword: true,

                autofillHints: const [AutofillHints.password],
                textInputAction: TextInputAction.done,

                keyboardType: TextInputType.visiblePassword,
                validator: (value) => Validators.confirmPassword(
                  value,
                  newPasswordController.text,
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: ' تحديث كلمة المرور',
                  onPressed: () {
                    _update(context);
                  },
                  height: 45.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _update(BuildContext context) {
    if (_formKey.currentState?.validate() == false) {
      return;
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialog(title: "تم تحديث كلمة المرور بنجاح");
        },
      );
    }
  }
}
