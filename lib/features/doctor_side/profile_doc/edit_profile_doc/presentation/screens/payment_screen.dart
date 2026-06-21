import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/special_container.dart';

class PaymentScreenInfo extends StatefulWidget {
  const PaymentScreenInfo({super.key});

  @override
  State<PaymentScreenInfo> createState() => _PaymentScreenInfoState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _idController = TextEditingController();
final TextEditingController _bankNameController = TextEditingController();
final TextEditingController _accountNumberController = TextEditingController();

class _PaymentScreenInfoState extends State<PaymentScreenInfo> {
  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorProfileCubit, DoctorProfileState>(
      listener: (context, state) {
        if (state is PaymentLoading) {
          UiUtils.showLoading(context);
        }

        if (state is PaymentSuccess) {
          UiUtils.hideDialog(context);

          showDialog(
            context: context,
            builder: (_) {
              return CustomDialog(
                title: "تم تحديث البيانات بنجاح",
                isButton: false,
              );
            },
          );
          context.read<DoctorProfileCubit>().getDoctorProfile();
        }

        if (state is PaymentError) {
          UiUtils.hideDialog(context);

          UiUtils.showMessage(
            message: state.message,
            bgColor: Colors.red,
            fgColor: Colors.white,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "تعديل بيانات الدفع",
            style: AppTypography.appBarTitelStyle,
          ),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardWidget(
                    verticalPadding: 36.r,
                    horizontalPadding: 16.r,
                    widget: Column(
                      children: [
                        Text(
                          "بيانات التحويل البنكي",
                          style: AppTypography.subTitelStyle,
                        ),
                        HeightSpace(18),
                        SpecialContainer(
                          title: "بيانات مشفرة وآمنة",
                          bgColor: AppColors.greenbg,
                          titleColor: AppColors.titlegreen,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: "اسم حامل البطاقة",

                          validator: (value) => Validators.required(value),
                          controller: _nameController,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: "رقم الحساب",

                          validator: (value) => Validators.required(value),
                          controller: _idController,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: "البنك الخاص بك",
                          controller: _bankNameController,
                          validator: (value) => Validators.required(value),
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          prefixIcon: Icon(Icons.location_on_outlined),
                          label: "IBAN",
                          textDirection: TextDirection.ltr,
                          controller: _accountNumberController,

                          validator: (value) => Validators.required(value),
                        ),

                        HeightSpace(8),
                        Text(
                          "يرجى التأكد من كتابة الـ IBAN بشكل صحيح ليبدأ بـ SA",
                          style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.oil,
                          ),
                        ),
                      ],
                    ),
                  ),

                  HeightSpace(20),

                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "حفظ التعديلات",
                      onPressed: () {
                        context.read<DoctorProfileCubit>().updatePaymentInfo(
                          request: UpdatePaymentInfoRequest(
                            accountHolderName: _nameController.text,
                            accountNumber: _idController.text,
                            bankName: _bankNameController.text,
                            iban: _accountNumberController.text,
                            transferPeriod: '',
                          ),
                        );
                      },
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
