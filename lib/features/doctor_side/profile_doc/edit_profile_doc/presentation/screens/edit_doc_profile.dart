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
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_doctor_profile_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';

class EditDocProfileScreen extends StatefulWidget {
  const EditDocProfileScreen({super.key, required this.profile});
  final DoctorProfileEntity profile;
  @override
  State<EditDocProfileScreen> createState() => _EditDocProfileScreenState();
}

class _EditDocProfileScreenState extends State<EditDocProfileScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();
  final TextEditingController _infoControler = TextEditingController();
  String? currentImageUrl;
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _namecontroller.text = widget.profile.fullName;
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailControler.dispose();
    _phoneControler.dispose();
    _infoControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
      listener: (context, state) {
        if (state is DoctorProfileUpdated) {
          UiUtils.hideDialog(context);
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
          context.read<DoctorProfileCubit>().getDoctorProfile();
        }
        // if (state is UpdateProfileLoading) {
        //   UiUtils.showLoading(context);
        // }
        if (state is DoctorProfileError) {
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
              "تعديل الملف الشخصي",
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
                      width: double.infinity,
                      verticalPadding: 16.r,
                      widget: Column(
                        children: [
                          Text(
                            'المعلومات الشخصية',
                            style: AppTypography.subTitelStyle,
                          ),
                          HeightSpace(18),
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
                            label: "النبذه",
                            maxLines: 4,
                            controller: _infoControler,
                            validator: (value) => Validators.required(value),
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
                  ],
                ),
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
      context.read<DoctorProfileCubit>().updateDoctorProfile(
        request: UpdateDoctorProfileRequest(
          fullName: _namecontroller.text,
          email: _emailControler.text,
          phone: _phoneControler.text,
          bio: _infoControler.text,
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
