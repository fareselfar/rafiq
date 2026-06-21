import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class CustomHomeSearchWidget extends StatelessWidget {
  const CustomHomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AssetsManger.search, height: 240.h),
        HeightSpace(8),
        Text(
          'ابدأ البحث عن طبيب أو تخصص',
          style: GoogleFonts.cairo(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.info,
          ),
        ),
        HeightSpace(8),
        Text(
          'اكتب اسم الطبيب او التخصص للعثور على',
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.selectedText,
          ),
        ),
        Text(
          'ما يناسبك بسرعة وسهولة',
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.selectedText,
          ),
        ),
      ],
    );
  }
}
