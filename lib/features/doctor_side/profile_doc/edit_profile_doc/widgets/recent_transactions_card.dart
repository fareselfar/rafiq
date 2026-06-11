import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/special_container.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({
    super.key,
    this.title1,
    this.title2,
    this.title3,
    this.icon,
    this.price,
    this.bgSpecialCard,
    this.fgSpecialCard,
    this.transTitle,
  });
  final String? title1;
  final String? title2;
  final String? title3;
  final String? price;
  final String? transTitle;

  final String? icon;
  final Color? bgSpecialCard;
  final Color? fgSpecialCard;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      horizontalPadding: 16.w,
      verticalPadding: 20.h,
      width: double.infinity,
      widget: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(title1 ?? '', style: AppTypography.inputTextFormStyle),
                  WidthSpace(4),
                  Text(title2 ?? '', style: AppTypography.inputTextFormStyle),
                ],
              ),
              SpecialContainer(
                title: transTitle ?? '',
                bgColor: bgSpecialCard ?? Colors.transparent,
                titleColor: fgSpecialCard ?? Colors.transparent,
              ),
            ],
          ),
          HeightSpace(12),
          Divider(color: AppColors.divider),
          HeightSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(icon ?? ""),
              WidthSpace(4),
              Text(title3 ?? '', style: AppTypography.inputTextFormStyle),
              Text(
                price ?? '',
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.priceColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
