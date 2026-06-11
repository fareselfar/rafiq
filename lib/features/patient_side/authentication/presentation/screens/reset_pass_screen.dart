import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/authentication/data/models/reset_password_request.dart';
import 'package:rafiq/features/patient_side/authentication/presentation/bloc/authentication_cubit.dart';

class ResetPassScreen extends StatefulWidget {
  const ResetPassScreen({super.key, required this.email, required this.otp});
  final String email;
  final String otp;
  @override
  State<ResetPassScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ResetPassScreen> {
  late TextEditingController passController;
  late TextEditingController rePassController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    passController = TextEditingController();
    rePassController = TextEditingController();
  }

  @override
  void dispose() {
    passController.dispose();
    rePassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          UiUtils.showLoading(context);
        }

        if (state is ResetPassSuccess) {
          UiUtils.hideDialog(context);
          context.navigateAndReplace('/successResetPass');
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
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تعيين كلمة مرور جديدة',
                    textAlign: TextAlign.center,
                    style: AppTypography.primaryHeadLinesStyle.copyWith(
                      fontSize: 38.sp,
                      height: 1.2,
                    ),
                  ),
                  HeightSpace(20),
                  Align(
                    alignment: Alignment.centerRight,

                    child: Text(
                      ' أدخل كلمة المرور الجديدة لإعادة تعيين \nحسابك',
                      style: AppTypography.subTitelStyle.copyWith(
                        fontSize: 18.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  HeightSpace(20),

                  CustomTextField(
                    label: 'كلمة المرور الجديدة',
                    controller: passController,
                    hint: 'أدخل كلمة المرور الجديدة',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    validator: Validators.combine([
                      (value) => Validators.required(
                        value,
                        fieldName: 'كلمة المرور الجديدة',
                      ),
                      (value) => Validators.email(value),
                    ]),
                    inputStyle: AppTypography.inputTextFormStyle,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  HeightSpace(20),
                  CustomTextField(
                    label: 'تأكيد كلمة المرور',
                    controller: rePassController,
                    hint: 'أدخل كلمة المرور الجديدة مرة أخرى',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    validator: Validators.combine([
                      (value) => Validators.required(
                        value,
                        fieldName: 'تأكيد كلمة المرور',
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
                          context.read<AuthenticationCubit>().resetPass(
                            request: ResetPasswordRequest(
                              newPassword: passController.text,
                              confirmPassword: rePassController.text,
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
