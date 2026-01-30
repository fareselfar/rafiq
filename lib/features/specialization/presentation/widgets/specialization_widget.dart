import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/onbording/models/specialization_model.dart';

class SpecializationWidget extends StatelessWidget {
  const SpecializationWidget({super.key, required this.specializationModel});
  final SpecializationModel specializationModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 200.h,
          width: 162.w,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 1.w),
            borderRadius: BorderRadius.circular(24.r),
            color: AppColors.surface,
          ),
          child: Padding(
            padding: REdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(specializationModel.image, width: 70),
                HeightSpace(8),
                Text(
                  specializationModel.name,
                  style: GoogleFonts.changa(
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                  ),
                ),
                HeightSpace(8),
                Text(
                  specializationModel.numberOfDoctors,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
