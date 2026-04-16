import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/card_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
  }

  void _update(BuildContext context) {
    if (_formKey.currentState?.validate() == false) {
      return;
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CustomDialog(title: "تم تحديث البيانات بنجاح", isButton: true);
        },
      );
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
    }
  }
}
