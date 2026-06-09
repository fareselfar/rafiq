import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class ClassifyWidget extends StatelessWidget {
  const ClassifyWidget({
    super.key,
    required this.bgColor,
    required this.fgColor,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final Color bgColor;
  final Color fgColor;
  final String icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(width: 1.w, color: fgColor),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            children: [
              SvgPicture.asset(icon, height: 22.h),
              WidthSpace(5),
              Text(
                text,
                style: GoogleFonts.cairo(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: fgColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
