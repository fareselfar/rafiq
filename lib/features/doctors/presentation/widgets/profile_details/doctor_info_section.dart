import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/custom_details_container.dart';

class DoctorInfoSection extends StatelessWidget {
  final DoctorsEntity doctor;

  const DoctorInfoSection({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundImage: doctor.imageUrl.startsWith('http')
              ? NetworkImage(doctor.imageUrl) as ImageProvider
              : AssetImage(doctor.imageUrl),
        ),
        HeightSpace(8.h),

        Text(
          doctor.name,
          style: AppTypography.doctorName,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        HeightSpace(5.h),
        Text(
          doctor.specialization,
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
            '⭐ ${doctor.rating} (${doctor.reviewCount} مراجعة)',
            style: AppTypography.bodymid.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        HeightSpace(12.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
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
                      doctor.address,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'سعر الكشف : ',
                    style: AppTypography.bodymid.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '${doctor.consultationPrice} جنيه',
                      style: AppTypography.bodymid.copyWith(
                        color: AppColors.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                title: '+${doctor.yearsOfExperience}',
                subTitle: 'سنوات خبرة',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomDetailsContainer(
                icon: Icons.groups_outlined,
                title: '+${doctor.patientCount}',
                subTitle: 'مريض',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomDetailsContainer(
                icon: Icons.access_time,
                title: '${doctor.waitingTime} د',
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
              doctor.bio.isEmpty
                  ? "لا توجد نبذة تعريفية متاحة حالياً."
                  : doctor.bio,
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
