import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'custom_details_container.dart';

class DoctorInfoSection extends StatelessWidget {
  final DoctorProfileEntity profile;

  const DoctorInfoSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final hasImage = profile.imagePath != null && profile.imagePath!.isNotEmpty;

    return Column(
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundColor: const Color(0xFFE3F2FD),
          backgroundImage: hasImage ? NetworkImage(profile.imagePath!) : null,
          child: !hasImage
              ? Icon(Icons.person, size: 60.r, color: const Color(0xFF90CAF9))
              : null,
        ),
        HeightSpace(8.h),

        Text(
          profile.fullName,
          style: AppTypography.doctorName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        HeightSpace(5.h),
        Text(
          profile.specialization,
          style: AppTypography.bodymid.copyWith(color: AppColors.primary),
          textAlign: TextAlign.center,
        ),
        HeightSpace(8.h),

        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            '⭐ ${profile.rate.toStringAsFixed(1)} (${profile.reviewsCount} مراجعة)',
            style: AppTypography.bodymid.copyWith(color: AppColors.textSecondary),
          ),
        ),
        HeightSpace(12.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // العنوان
              if (profile.address != null && profile.address!.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        profile.address!,
                        style: AppTypography.bodymid.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),

              HeightSpace(8.h),

              if (profile.price != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'سعر الكشف : ',
                      style: AppTypography.bodymid.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${profile.price!.toInt()} جنيه',
                      style: AppTypography.bodymid.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),

        HeightSpace(20.h),

        Row(
          children: [
            Expanded(
              child: CustomDetailsContainer(
                icon: Icons.workspace_premium_outlined,
                title: '+${profile.yearsOfExperience}',
                subTitle: 'سنوات خبرة',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomDetailsContainer(
                icon: Icons.groups_outlined,
                title: '+${profile.patientsCount}',
                subTitle: 'مريض',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomDetailsContainer(
                icon: Icons.access_time,
                title: '${profile.waitingTime} د',
                subTitle: 'مدة الانتظار',
              ),
            ),
          ],
        ),

        HeightSpace(24.h),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text('نبذة عن الطبيب', style: AppTypography.doctorName),
            ),
            HeightSpace(8.h),
            Text(
              profile.bio.isEmpty
                  ? 'لا توجد نبذة تعريفية متاحة حالياً.'
                  : profile.bio,
              style: AppTypography.profileServiceNameStyle,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ],
    );
  }
}