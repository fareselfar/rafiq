import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class ArticleSuccessDialog extends StatefulWidget {
  final String message;
  const ArticleSuccessDialog({super.key, required this.message});

  @override
  State<ArticleSuccessDialog> createState() => _ArticleSuccessDialogState();
}

class _ArticleSuccessDialogState extends State<ArticleSuccessDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: SizedBox(
        height: 240.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2.5),
              ),
              child: Icon(Icons.check, color: AppColors.primary, size: 36.sp),
            ),
            const HeightSpace(16),
            Text(widget.message, style: AppTypography.dialogTitle),
          ],
        ),
      ),
    );
  }
}
