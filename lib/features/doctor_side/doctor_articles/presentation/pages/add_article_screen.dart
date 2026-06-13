import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_cubit.dart';
import 'package:rafiq/features/doctor_side/doctor_articles/presentation/bloc/doctor_articles_state.dart';
import '../../domain/entities/article_entity.dart';
import '../widgets/article_success_dialog.dart';

class AddArticleScreen extends StatefulWidget {
  final ArticleEntity? articleToEdit;
  const AddArticleScreen({super.key, this.articleToEdit});

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _shortDescController = TextEditingController();

  File? _pickedImage;
  String? _selectedCategory;

  static const _categories = [
    'نصائح عامة',
    'تغذية',
    'قلب',
    'أطفال',
    'جلدية',
    'عظام',
    'نفسية',
  ];

  bool get _isEditing => widget.articleToEdit != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final a = widget.articleToEdit!;
      _titleController.text = a.title;
      _contentController.text = a.content;
      _selectedCategory = a.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _shortDescController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) setState(() => _pickedImage = File(picked.path));
  }

  void _submit({required bool publish}) {
    if (!_formKey.currentState!.validate()) return;
    context.read<DoctorArticlesCubit>().addArticle(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          category: _selectedCategory ?? '',
          shortDescription: _shortDescController.text.trim(),
          image: _pickedImage,
          publish: publish,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          color: AppColors.textPrimary,
        ),
        title: Text(
          'اضافه مقال',
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: BlocConsumer<DoctorArticlesCubit, DoctorArticlesState>(
        listener: (context, state) {
          if (state is AddArticleSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => ArticleSuccessDialog(
                message: state.isPublished ? 'تم نشر المقال' : 'تم الحفظ كمسوده',
              ),
            ).then((_) => Navigator.pop(context));
          }
          if (state is AddArticleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddArticleLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title
                  _SectionLabel(label: 'عنوان المقال'),
                  const HeightSpace(8),
                  CustomTextField(
                    controller: _titleController,
                    hint: 'ادخل عنوانا جذابا لمقالك',
                    textDirection: TextDirection.rtl,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'أدخل عنوان المقال' : null,
                  ),
                  const HeightSpace(20),

                  // Image picker
                  _SectionLabel(label: 'اضف صوره'),
                  const HeightSpace(8),
                  _ImagePickerBox(
                    pickedImage: _pickedImage,
                    onTap: _pickImage,
                  ),
                  const HeightSpace(20),

                  // Category
                  _SectionLabel(label: 'التصنيف الطبي'),
                  const HeightSpace(8),
                  _CategoryDropdown(
                    selected: _selectedCategory,
                    categories: _categories,
                    onChanged: (v) => setState(() => _selectedCategory = v),
                  ),
                  const HeightSpace(20),

                  // Short description
                  _SectionLabel(label: 'وصف مختصر'),
                  const HeightSpace(8),
                  CustomTextField(
                    controller: _shortDescController,
                    hint: 'ملخص قصير للمقال...',
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'أدخل وصفًا مختصرًا' : null,
                  ),
                  const HeightSpace(20),

                  // Content
                  _SectionLabel(label: 'محتوى المقال'),
                  const HeightSpace(8),
                  _ContentEditor(controller: _contentController),
                  const HeightSpace(32),

                  // Publish button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'نشر المقال',
                      isLoading: isLoading,
                      onPressed: isLoading ? null : () => _submit(publish: true),
                    ),
                  ),
                  const HeightSpace(12),

                  // Save as draft button
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'حفظ كمسوده',
                      type: ButtonType.outlined,
                      isLoading: isLoading,
                      onPressed: isLoading ? null : () => _submit(publish: false),
                    ),
                  ),
                  const HeightSpace(24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Helper sub-widgets ────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.cairo(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _ImagePickerBox extends StatelessWidget {
  final File? pickedImage;
  final VoidCallback onTap;

  const _ImagePickerBox({required this.pickedImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.4),
            style: BorderStyle.solid,
            width: 1.5,
          ),
        ),
        child: pickedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.file(pickedImage!, fit: BoxFit.cover),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.image_outlined,
                        color: AppColors.primary, size: 32.sp),
                  ),
                  const HeightSpace(8),
                  Text(
                    'اضغط هنا لرفع صورة الغلاف',
                    style: GoogleFonts.cairo(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'أو اسحب الصورة وأفلتها هنا',
                    style: GoogleFonts.cairo(
                      fontSize: 12.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '(JPG, PNG - 5MB بحد أقصى)',
                    style: GoogleFonts.cairo(
                      fontSize: 11.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  final String? selected;
  final List<String> categories;
  final ValueChanged<String?> onChanged;

  const _CategoryDropdown({
    required this.selected,
    required this.categories,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          hint: Text(
            'اختر التصنيف المناسب',
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: AppColors.hintStyle,
            ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: categories
              .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c,
                        style: GoogleFonts.cairo(
                            fontSize: 14.sp,
                            color: AppColors.textPrimary)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _ContentEditor extends StatelessWidget {
  final TextEditingController controller;
  const _ContentEditor({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          // Toolbar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            child: Row(
              children: [
                _ToolbarButton(icon: Icons.redo),
                _ToolbarButton(icon: Icons.undo),
                _ToolbarButton(icon: Icons.image_outlined),
                _ToolbarButton(icon: Icons.format_quote),
                _ToolbarButton(icon: Icons.link),
                _ToolbarButton(icon: Icons.format_list_numbered),
                _ToolbarButton(icon: Icons.format_list_bulleted),
                _ToolbarButton(icon: Icons.format_italic),
                _ToolbarButton(
                    icon: Icons.format_bold, bold: true),
              ],
            ),
          ),
          // Text area
          TextFormField(
            controller: controller,
            maxLines: 12,
            textDirection: TextDirection.rtl,
            validator: (v) =>
                v == null || v.isEmpty ? 'أدخل محتوى المقال' : null,
            decoration: InputDecoration(
              hintText: '.......',
              hintTextDirection: TextDirection.rtl,
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            ),
            style: GoogleFonts.cairo(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final bool bold;
  const _ToolbarButton({required this.icon, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Icon(
        icon,
        size: 18.sp,
        color: bold ? AppColors.textPrimary : Colors.grey.shade600,
      ),
    );
  }
}
