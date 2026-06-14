import 'dart:io';

import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_profile/data/models/file_type.dart';

import 'package:rafiq/features/patient_profile/data/models/upload_file_request.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/dropdown_card.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  fp.PlatformFile? selectedFile;
  FileType selectedType = FileType.tests;
  final TextEditingController _notesControler = TextEditingController();

  Future<void> pickFile() async {
    final result = await fp.FilePicker.platform.pickFiles(
      type: fp.FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        selectedFile = result.files.first;
      });
    }
  }

  @override
  void dispose() {
    _notesControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('رفع ملف', style: AppTypography.appBarTitelStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: 36,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.surface),
                child: Padding(
                  padding: REdgeInsets.symmetric(vertical: 36, horizontal: 33),
                  child: InkWell(
                    onTap: () async {
                      await pickFile();
                    },
                    child: CardWidget(
                      width: 2,
                      borderColor: AppColors.hintStyle,
                      cardColor: AppColors.notes,
                      widget: Padding(
                        padding: REdgeInsets.only(top: 39, bottom: 16),
                        child: Column(
                          children: [
                            SvgPicture.asset(SvgManger.uploadFile),
                            HeightSpace(12),
                            Text(
                              "رفع الملفات الطبية",
                              style: AppTypography.uploadFileTitle,
                            ),
                            HeightSpace(12),
                            Text(
                              "حتى 10 ميجا PNG , JPG ,PDF",
                              style: AppTypography.inputTextFormStyle,
                            ),
                            if (selectedFile != null) ...[
                              HeightSpace(12),
                              Text(
                                selectedFile?.name ?? '',
                                style: AppTypography.bodymid,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              HeightSpace(20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.surface),
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 16, vertical: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("نوع الملف", style: AppTypography.inputLabel),
                      HeightSpace(8),
                      DropdownCard(
                        title: "نوع الملف",
                        width: double.infinity,
                        customDropdownOptions: DropdownButton<FileType>(
                          value: selectedType,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.hintStyle,
                          ),
                          underline: const SizedBox(),
                          items: FileType.values
                              .where((e) => e != FileType.all)
                              .map((type) {
                                return DropdownMenuItem<FileType>(
                                  value: type,
                                  child: Text(type.name),
                                );
                              })
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedType = value!;
                            });
                          },
                        ),
                      ),
                      HeightSpace(43),
                      Row(
                        children: [
                          SvgPicture.asset(SvgManger.pen),
                          WidthSpace(4),
                          Text("ملاحظات", style: AppTypography.notes),
                        ],
                      ),
                      HeightSpace(40),
                      CustomTextField(
                        maxLines: 6,
                        hint: "أدخل أي ملاحظات اضافية هنا",
                        hintStyle: AppTypography.bodymid,
                        controller: _notesControler,
                      ),
                      HeightSpace(56),
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: 'رفع الملف',
                          onPressed: () {
                            if (selectedFile == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('اختر ملف أولاً')),
                              );
                              return;
                            }

                            context.read<ProfileCubit>().uploadFile(
                              request: UploadFileRequest(
                                file: File(selectedFile!.path!),
                                fileType: selectedType.name,
                                fileName: selectedFile!.name,
                                notes: _notesControler.text,
                              ),
                            );
                          },
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
}
