import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/custom_button.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key, this.title, this.isButton = false});
  final bool isButton;
  final String? title;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.goBack();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 410.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(SvgManger.success),
            Text(widget.title ?? "", style: AppTypography.dialogTitle),
            widget.isButton
                ? SizedBox.shrink()
                : Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 180.w,
                      child: CustomButton(
                        text: "المتابعة",
                        onPressed: () {
                          context.goBack();
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
