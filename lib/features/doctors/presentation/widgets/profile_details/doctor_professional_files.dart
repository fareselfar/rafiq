import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';

class DoctorProfessionalFiles extends StatelessWidget {
  const DoctorProfessionalFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الملفات المهنية',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20.r),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              ProfessionalFileItem(
                title: 'شهادة التخصص',
                icon: Icons.assignment_outlined,
                iconBgColor: const Color(0xFFE3F2FD),
                iconColor: Colors.blue,
              ),
              SizedBox(height: 8.h),
              ProfessionalFileItem(
                title: 'ترخيص مزاولة المهنة',
                icon: Icons.badge_outlined,
                iconBgColor: const Color(0xFFE8F5E9),
                iconColor: Colors.green,
              ),
              SizedBox(height: 8.h),
              ProfessionalFileItem(
                title: 'صور العيادة',
                icon: Icons.image_outlined,
                iconBgColor: const Color(0xFFF3E5F5),
                iconColor: Colors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfessionalFileItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const ProfessionalFileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF212121),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.visibility_outlined,
            color: Colors.grey.shade500,
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}
