import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/card_widget.dart';

class ProfitsWidget extends StatelessWidget {
  const ProfitsWidget({
    super.key,
    this.borderColor,
    this.title1,
    this.title2,
    this.icon,
  });
  final Color? borderColor;
  final String? title1;
  final String? title2;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      horizontalPadding: 16.w,
      borderColor: borderColor ?? AppColors.backGround,
      width: double.infinity,
      borderWidth: 2.w,
      verticalPadding: 21.h,
      widget: Row(
        children: [
          SvgPicture.asset(icon ?? ""),
          WidthSpace(16),
          Column(
            children: [
              Text(title1 ?? '', style: AppTypography.inputTextFormStyle),
              WidthSpace(2),
              Text(title2 ?? '', style: AppTypography.inputTextFormStyle),
            ],
          ),
        ],
      ),
    );
  }
}
