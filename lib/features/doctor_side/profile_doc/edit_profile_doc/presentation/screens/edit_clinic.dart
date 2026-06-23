import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/custom_date_picker.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';

class EditClinic extends StatefulWidget {
  const EditClinic({super.key});

  @override
  State<EditClinic> createState() => _EditClinicState();
}

final TextEditingController _medicalLicenseController = TextEditingController();
final TextEditingController _clinicNameController = TextEditingController();
final TextEditingController _locationController = TextEditingController();
final TextEditingController _fromController = TextEditingController();
final TextEditingController _toController = TextEditingController();
final TextEditingController _priceController = TextEditingController();

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _EditClinicState extends State<EditClinic> {
  final workHours =
      '${_fromController.text.trim()} - ${_toController.text.trim()}';
  @override
  void dispose() {
    _clinicNameController.dispose();
    _medicalLicenseController.dispose();
    _locationController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorProfileCubit, DoctorProfileState>(
      listener: (context, state) {
        if (state is UpdateClinicInfoSuccess) {
          UiUtils.hideDialog(context);
          context.read<DoctorProfileCubit>().getDoctorProfile();
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (_) => CustomDialog(title: "تم تحديث البيانات بنجاح"),
          );
        }
        if (state is UpdateClinicInfoError) {
          UiUtils.hideDialog(context);
          UiUtils.showMessage(
            message: state.message,
            bgColor: Colors.red,
            fgColor: Colors.white,
          );
        }
        if (state is UpdateClinicInfoLoading) {
          UiUtils.showLoading(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "تعديل بيانات العياده",
            style: AppTypography.appBarTitelStyle,
          ),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardWidget(
                  verticalPadding: 36.r,
                  horizontalPadding: 16.r,
                  widget: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "معلومات العياده",
                          style: AppTypography.subTitelStyle,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          label: "رقم الترخيص الطبي",
                          prefixIcon: Icon(Icons.person_pin_outlined),
                          validator: (value) => Validators.required(value),
                          controller: _medicalLicenseController,
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          prefixIcon: Icon(Icons.business_outlined),
                          label: "المستشفى /  العيادة",
                          controller: _clinicNameController,
                          validator: (value) => Validators.required(value),
                        ),
                        HeightSpace(18),
                        CustomTextField(
                          prefixIcon: Icon(Icons.location_on_outlined),
                          label: "العنوان",
                          textDirection: TextDirection.ltr,
                          controller: _locationController,

                          validator: (value) => Validators.required(value),
                        ),
                        HeightSpace(18),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 144.w,
                              child: CustomDatePicker(
                                controller: _fromController,
                                hint: "من",
                              ),
                            ),
                            SizedBox(
                              width: 144.w,
                              child: CustomDatePicker(
                                controller: _toController,
                                hint: "الي",
                              ),
                            ),
                          ],
                        ),
                        HeightSpace(18),

                        CustomTextField(
                          keyboardType: TextInputType.number,
                          label: "سعر الكشف",
                          controller: _priceController,
                          validator: (value) => Validators.required(value),
                        ),

                        HeightSpace(18),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: "حفظ التعديلات",
                              onPressed: () {
                                _saveClinic();
                              },
                            ),
                          ),
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

  void _saveClinic() async {
    if (!_formKey.currentState!.validate()) return;
    context.read<DoctorProfileCubit>().updateClinicInfo(
      request: UpdateClinicInfoRequest(
        medicalLicense: _medicalLicenseController.text,
        clinicName: _clinicNameController.text,
        address: _locationController.text,
        workHours: workHours,
        price: double.parse(_priceController.text.trim()),
      ),
    );
  }

  Future<void> pickTime(TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      controller.text = picked.format(context);
    }
  }
}
