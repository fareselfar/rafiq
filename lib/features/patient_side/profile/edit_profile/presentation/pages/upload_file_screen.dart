import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_profile/data/models/file_type.dart';
import 'package:rafiq/features/patient_side/patient_profile/data/repositories/file_repository.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/dropdown_card.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/file_controller.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  final TextEditingController _notesControler = TextEditingController();

  late final FileController controller;

  @override
  void initState() {
    controller = FileController(FileRepository());
    super.initState();
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
                      final error = await controller.pickFile();

                      if (error != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(error)));
                      }

                      setState(() {});
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
                            if (controller.selectedFile != null) ...[
                              HeightSpace(12),
                              Text(
                                controller.selectedFile!.name,
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
                          value: controller.selectedType,
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
                                  child: Text(type.displayName),
                                );
                              })
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              controller.selectedType = value!;
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
                            final error = controller.addFile(
                              _notesControler.text,
                            );

                            if (error != null) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(error)));
                              return;
                            }

                            Navigator.pop(context);
                          },
                          height: 45.h,
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
