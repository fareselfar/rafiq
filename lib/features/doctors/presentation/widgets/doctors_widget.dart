import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';

class DoctorsWidget extends StatelessWidget {
  DoctorsWidget({super.key, required this.doctorModel});
  DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20.r,
            spreadRadius: 2.r,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: REdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(doctorModel.image),
                    radius: 40.r,
                  ),
                  WidthSpace(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorModel.doctorName,
                        style: GoogleFonts.cairo(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.selectedText,
                        ),
                      ),
                      HeightSpace(8),
                      Text(
                        doctorModel.doctorSpecialization,
                        style: GoogleFonts.cairo(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            HeightSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(IconManger.doctor, height: 20.h),
                WidthSpace(5.5),
                Padding(
                  padding: REdgeInsets.only(left: 20),
                  child: Text(
                    doctorModel.doctorRate,
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.selectedText,
                    ),
                  ),
                ),
              ],
            ),
            HeightSpace(12),
            Row(
              children: [
                Image.asset(IconManger.locationIcon, height: 20.h),
                WidthSpace(4),
                Text(
                  doctorModel.doctorLocation,
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.selectedText,
                  ),
                ),
                Spacer(),
                Image.asset(IconManger.walletIcon, height: 25.h),
                WidthSpace(4),
                Text(
                  doctorModel.doctorPrice,
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.selectedText,
                  ),
                ),
              ],
            ),
            HeightSpace(12),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: doctorModel.onTap,
                child: CustomButton(
                  text: 'احجز الآن',
                  onPressed: () {},
                  height: 45.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
