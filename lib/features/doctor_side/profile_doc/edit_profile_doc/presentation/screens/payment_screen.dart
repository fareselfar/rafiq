import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/special_container.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _idController = TextEditingController();
final TextEditingController _bankNameController = TextEditingController();
final TextEditingController _accountNumberController = TextEditingController();

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void dispose() {
    _idController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        label: "محمد علي",
                        prefixIcon: Icon(Icons.person_pin_outlined),
                        validator: (value) => Validators.required(value),
                        controller: _idController,
                      ),
                      HeightSpace(18),
                      CustomTextField(
                        prefixIcon: Icon(Icons.business_outlined),
                        label: "البنك الخاص بك",
                        controller: _bankNameController,
                        validator: (value) => Validators.required(value),
                      ),
                      HeightSpace(18),
                      CustomTextField(
                        prefixIcon: Icon(Icons.location_on_outlined),
                        label: "رقم الحساب/IBAN",
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
                      CustomDialog(
                        title: "تم تحديث البيانات بنجاح",
                        isButton: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
