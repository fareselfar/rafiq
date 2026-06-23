import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';

class CustomNotificationWidget extends StatelessWidget {
  const CustomNotificationWidget({
    super.key,
    this.title1,
    this.title2,
    this.icon,
    this.timeTitle,
  });
  final String? title1;
  final String? title2;
  final String? icon;
  final String? timeTitle;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      horizontalPadding: 16.w,
      width: double.infinity,
      borderWidth: 2.w,
      verticalPadding: 21.h,
      widget: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon ?? "", width: 40.w),
          WidthSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title1 ?? '', style: AppTypography.doctorName),
                HeightSpace(4),
                Text(title2 ?? '', style: AppTypography.inputTextFormStyle),
              ],
            ),
          ),
          WidthSpace(4),
          Text(timeTitle ?? '', style: AppTypography.inputTextFormStyle),
        ],
      ),
    );
  }
}
