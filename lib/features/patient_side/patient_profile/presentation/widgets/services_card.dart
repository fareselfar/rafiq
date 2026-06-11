import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_fonts.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/card_widget.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    super.key,
    required this.serviceName,
    required this.servicesDetails,
    required this.borderColor,
    this.textColor = AppColors.textPrimary,
    required this.icon,
    required this.onTap,
  });
  final String serviceName;
  final String servicesDetails;
  final Color borderColor;
  final Color textColor;
  final String icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      borderWidth: 1,
      width: 161.w,
      borderColor: borderColor,
      horizontalPadding: 16.r,
      verticalPadding: 16.r,
      widget: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                WidthSpace(4),
                Text(
                  serviceName,
                  style: TextStyle(
                    fontFamily: AppFonts.mainFontName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
            HeightSpace(21),
            Text(servicesDetails, style: AppTypography.profileServiceNameStyle),
          ],
        ),
      ),
    );
  }
}
