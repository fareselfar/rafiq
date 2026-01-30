import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';
import 'package:rafiq/features/home/data/models/patient_time_model.dart';
import 'package:rafiq/features/home/presentation/widgets/gradient_card.dart';

class PatientTime extends StatelessWidget {
  PatientTime({super.key, required this.patientTimeModel});
  PatientTimeModel patientTimeModel;
  @override
  Widget build(BuildContext context) {
    return GradientCard(
      child: Padding(
        padding: REdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(patientTimeModel.img),
                  radius: 40.r,
                ),
                WidthSpace(8),
                Column(
                  children: [
                    Text(
                      patientTimeModel.doctorName,
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.surface,
                      ),
                    ),
                    HeightSpace(8),
                    Text(
                      patientTimeModel.specialization,
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.surface,
                      ),
                    ),
                  ],
                ),
                WidthSpace(40),

                Icon(Icons.star, color: AppColors.warning),
                WidthSpace(4),
                Text(
                  patientTimeModel.rate,
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.surface,
                  ),
                ),
              ],
            ),
            HeightSpace(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: AppColors.surface),
                Text(
                  patientTimeModel.time,
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.surface,
                  ),
                ),
                WidthSpace(8),
                Icon(Icons.calendar_today_outlined, color: AppColors.surface),
                WidthSpace(4),
                Text(
                  patientTimeModel.date,
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.surface,
                  ),
                ),
              ],
            ),
            HeightSpace(4),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.surface),
                WidthSpace(4),
                Text(
                  patientTimeModel.location,
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.surface,
                  ),
                ),
              ],
            ),
            HeightSpace(8),
            Row(
              children: [
                CustomButton(
                  text: 'تعديل',
                  onPressed: () {},
                  iconColor: AppColors.primary,
                  borderRadius: 8,
                  textStyle: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: .5.h,
                  ),
                  width: 147.w,
                  height: 32.h,
                ),
                WidthSpace(16),
                CustomButton(
                  text: 'الغاء',
                  onPressed: () {},
                  backgroundColor: AppColors.darkRed,
                  borderRadius: 8,
                  textStyle: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    height: .5.h,
                  ),
                  width: 147.w,
                  height: 32.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
