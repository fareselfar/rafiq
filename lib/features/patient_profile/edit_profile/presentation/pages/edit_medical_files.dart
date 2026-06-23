import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_record_request.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/blood_type_dropdown.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/chronic_diasease_item.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/height_weight_field.dart';

class EditMedicalFileScreen extends StatefulWidget {
  const EditMedicalFileScreen({super.key});

  @override
  State<EditMedicalFileScreen> createState() => _EditMedicalFileScreenState();
}

class _EditMedicalFileScreenState extends State<EditMedicalFileScreen> {
  final allergyController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  bool hasPressure = false;
  bool hasDiabetes = false;
  bool hasHeartDisease = false;
  bool hasAsthma = false;
  bool hasImmunityDisease = false;
  bool hasNothing = false;

  String? bloodType = 'A+';

  @override
  void dispose() {
    allergyController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is MedicalRecordUpdated) {
          UiUtils.hideDialog(context);
          context.read<ProfileCubit>().getProfile();
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialog(
                title: "تم تحديث البيانات بنجاح",
                isButton: false,
              );
            },
          );
        }
        if (state is MedicalRecordLoading) {
          UiUtils.showLoading(context);
        }
        if (state is MedicalRecordError) {
          UiUtils.hideDialog(context);

          UiUtils.showMessage(
            message: state.message,
            bgColor: Colors.red,
            fgColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "تعديل الملف الطبي",
              style: AppTypography.appBarTitelStyle,
            ),
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SingleChildScrollView(
              child: CardWidget(
                horizontalPadding: 16,
                verticalPadding: 36,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "الأمراض المزمنة",
                        style: AppTypography.appBarTitelStyle.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),

                    HeightSpace(24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChronicDiseaseItem(
                          title: "ضغط",
                          value: hasPressure,
                          onChanged: (value) {
                            setState(() {
                              hasPressure = value ?? false;
                            });
                          },
                        ),
                        ChronicDiseaseItem(
                          title: "سكر",
                          value: hasDiabetes,
                          onChanged: (value) {
                            setState(() {
                              hasDiabetes = value ?? false;
                            });
                          },
                        ),
                        ChronicDiseaseItem(
                          title: "قلب",
                          value: hasHeartDisease,
                          onChanged: (value) {
                            setState(() {
                              hasHeartDisease = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),

                    HeightSpace(12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChronicDiseaseItem(
                          title: "ربو",
                          value: hasAsthma,
                          onChanged: (value) {
                            setState(() {
                              hasAsthma = value ?? false;
                            });
                          },
                        ),
                        ChronicDiseaseItem(
                          title: "مناعة",
                          value: hasImmunityDisease,
                          onChanged: (value) {
                            setState(() {
                              hasImmunityDisease = value ?? false;
                            });
                          },
                        ),
                        ChronicDiseaseItem(
                          title: "لا يوجد",
                          value: hasNothing,
                          onChanged: (value) {
                            setState(() {
                              hasNothing = value ?? false;

                              if (hasNothing) {
                                hasPressure = false;
                                hasDiabetes = false;
                                hasHeartDisease = false;
                                hasAsthma = false;
                                hasImmunityDisease = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                    HeightSpace(32),

                    CustomTextField(
                      label: "الحساسية",
                      controller: allergyController,
                    ),

                    HeightSpace(32),

                    Text("فصيلة الدم", style: AppTypography.inputLabel),

                    HeightSpace(8),

                    BloodTypeDropdown(
                      value: bloodType,
                      onChanged: (value) {
                        setState(() {
                          bloodType = value;
                        });
                      },
                    ),

                    HeightSpace(32),

                    Row(
                      children: [
                        HeightWeightField(
                          label: "الطول",
                          hint: "175 CM",
                          controller: heightController,
                        ),

                        WidthSpace(16),

                        HeightWeightField(
                          label: "الوزن",
                          hint: "70 KG",
                          controller: weightController,
                        ),
                      ],
                    ),

                    HeightSpace(36),

                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 180.w,
                        child: CustomButton(
                          text: "حفظ التعديلات",
                          onPressed: () {
                            context.read<ProfileCubit>().updateMedicalRecord(
                              request: UpdateMedicalRecordRequest(
                                bloodType: bloodType ?? '',
                                allergy: allergyController.text,
                                chronicDiseases: getSelectedDiseases(),
                                height:
                                    double.tryParse(heightController.text) ?? 0,
                                weight:
                                    double.tryParse(weightController.text) ?? 0,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> getSelectedDiseases() {
    List<String> diseases = [];
    if (hasNothing) {
      return ["لا يوجد"];
    }
    if (hasPressure) diseases.add("ضغط");
    if (hasDiabetes) diseases.add("سكر");
    if (hasHeartDisease) diseases.add("قلب");
    if (hasAsthma) diseases.add("ربو");
    if (hasImmunityDisease) diseases.add("مناعة");

    return diseases;
  }
}
