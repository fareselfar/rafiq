import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class CustomChatInput extends StatelessWidget {
  final TextEditingController controller;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget sendButton;
  final String hintText;
  final Color? backgroundColor;
  final Color? inputFieldColor;
  final TextStyle? inputStyle;

  const CustomChatInput({
    super.key,
    required this.controller,
    required this.sendButton,
    this.leading,
    this.actions,
    this.hintText = "اكتب سؤالك هنا ...",
    this.backgroundColor,
    this.inputFieldColor,
    this.inputStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLines: 5,
                minLines: 1,
                textDirection: TextDirection.rtl,
                cursorColor: AppColors.divider,
                style: inputStyle ?? AppTypography.inputTextFormStyle,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppTypography.inputHint,
                  filled: true,
                  fillColor: inputFieldColor ?? AppColors.backGround,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.r),
                    borderSide: BorderSide(width: 1.5, color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.r),
                    borderSide: BorderSide(width: 1.5, color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28.r),
                    borderSide: const BorderSide(
                      color: AppColors.border,
                      width: 1.5,
                    ),
                  ),

                  suffixIcon: actions != null && actions!.isNotEmpty
                      ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
                      : null,
                ),
              ),
            ),

            WidthSpace(5),
            sendButton,
          ],
        ),
      ),
    );
  }
}
