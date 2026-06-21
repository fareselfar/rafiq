import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_profile/data/models/update_profile_request.dart';
import 'package:rafiq/features/patient_profile/edit_profile/presentation/widgets/gender_item.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String selectedGender = 'male';

  final TextEditingController ageController = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    ageController.dispose();
    _namecontroller.dispose();
    _emailControler.dispose();
    _phoneControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          UiUtils.hideDialog(context);
          context.read<ProfileCubit>().getProfile();
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
          // Navigator.pop(context);
        }
        // if (state is UpdateProfileLoading) {
        //   UiUtils.showLoading(context);
        // }
        if (state is ProfileError) {
          UiUtils.hideDialog(context);
          UiUtils.showMessage(
            message: state.message,
            bgColor: Colors.red,
            fgColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        print('PROFILE SCREEN STATE => ${state.runtimeType}');
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "تعديل الملف الشخصي",
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
                    width: double.infinity,
                    verticalPadding: 16.r,
                    widget: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: selectedImage != null
                              ? Image.file(selectedImage!, fit: BoxFit.cover)
                              : Image.asset(IconManger.profileImg),
                        ),
                        HeightSpace(8),
                        Text("تغير الصوره", style: AppTypography.bodymid),
                      ],
                    ),
                  ),

                  HeightSpace(20),
                  CardWidget(
                    verticalPadding: 36.r,
                    horizontalPadding: 16.r,
                    widget: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'الاسم بالكامل ',
                            controller: _namecontroller,
                            validator: (value) => Validators.required(
                              value,
                              fieldName: 'الاسم بالكامل',
                            ),
                          ),
                          HeightSpace(18),
                          CustomTextField(
                            label: 'البريد الالكتروني ',
                            controller: _emailControler,
                            validator: (value) => Validators.email(value),
                          ),
                          HeightSpace(18),
                          CustomTextField(
                            label: 'رقم الهاتف',
                            textDirection: TextDirection.ltr,
                            controller: _phoneControler,
                            validator: (value) => Validators.phone(value),
                          ),
                          HeightSpace(18),
                          CustomTextField(
                            controller: ageController,
                            label: 'العمر',
                            hint: 'أدخل العمر',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'العمر مطلوب';
                              }

                              final age = int.tryParse(value);

                              if (age == null) {
                                return 'أدخل رقم صحيح';
                              }

                              if (age < 1 || age > 120) {
                                return 'العمر غير صحيح';
                              }

                              return null;
                            },
                          ),
                          HeightSpace(18),
                          Row(
                            children: [
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

                              SizedBox(width: 12.w),

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
                            ],
                          ),
                          HeightSpace(18),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 180.w,
                              child: CustomButton(
                                text: "حفظ التعديلات",
                                onPressed: () {
                                  _update(context);
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
        );
      },
    );
  }

  void _update(BuildContext context) {
    if (_formKey.currentState?.validate() == false) {
      return;
    } else {
      context.read<ProfileCubit>().updateProfile(
        request: UpdateProfileRequest(
          name: _namecontroller.text,
          email: _emailControler.text,
          phoneNumber: _phoneControler.text,
          age: int.parse(ageController.text),
          gender: selectedGender,
          image: selectedImage,
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }
}
