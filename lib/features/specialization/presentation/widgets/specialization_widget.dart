import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/specialization/domain/entities/specialization_entity.dart';

class SpecializationWidget extends StatelessWidget {
  const SpecializationWidget({
    super.key,
    required this.specializationEntity,
    required this.onTap,
  });
  final SpecializationEntity specializationEntity;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
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
                Image.asset(
                  getSpecializationImage(specializationEntity.name),
                  width: 50.w,
                ),
                HeightSpace(6),
                Text(
                  specializationEntity.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.changa(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                  ),
                ),
                HeightSpace(4),
                Text(
                  '${specializationEntity.doctorsCount} طبيب',
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

  String getSpecializationImage(String name) {
    switch (name.toLowerCase()) {
      case 'dentistry':
        return AssetsManger.dentistry;

      case 'internal medicine':
        return AssetsManger.internalMedicial;

      case 'pediatrics':
        return AssetsManger.children;

      case 'cardiology':
        return AssetsManger.heart;

      case 'ent':
        return AssetsManger.nose;

      case 'ophthalmology':
        return AssetsManger.eye;

      case 'obstetrics and gynecology':
        return AssetsManger.famicons;

      case 'dermatology':
        return AssetsManger.hand;

      default:
        return AssetsManger.dentistry;
    }
  }
}
