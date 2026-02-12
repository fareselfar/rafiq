import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/widgets/custom_details_container.dart';

class DoctorInfoSection extends StatelessWidget {
  final DoctorsEntity doctor;

  const DoctorInfoSection({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: doctor.imageUrl.startsWith('http')
              ? NetworkImage(doctor.imageUrl) as ImageProvider
              : AssetImage(doctor.imageUrl),
        ),
        HeightSpace(8.h),
        Text(
          doctor.name,
          style: TextStyle(
            color: AppColors.textLabel,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          doctor.specialization,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        HeightSpace(8.h),
        Text(
          '⭐ ${doctor.rating} (${doctor.reviewCount} مراجعة)',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.selectedText,
          ),
        ),
        HeightSpace(8.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/location.svg',
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(width: 4.w),
            Text(
              doctor.address,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.selectedText,
              ),
            ),
          ],
        ),
        HeightSpace(8.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'سعر الكشف : ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.selectedText,
              ),
            ),
            Text(
              '${doctor.consultationPrice} جنيه',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        HeightSpace(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomDetailsContainer(
                iconPath: 'assets/icons/details2.svg',
                title: '+${doctor.yearsOfExperience}',
                subTitle: 'سنوات خبره',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomDetailsContainer(
                iconPath: 'assets/icons/details1.svg',
                title: '+${doctor.patientCount}',
                subTitle: 'مريض',
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomDetailsContainer(
                iconPath: 'assets/icons/details3.svg',
                title: '${doctor.waitingTime}د',
                subTitle: 'مده الانتظار',
              ),
            ),
          ],
        ),
        HeightSpace(20.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'نبذة عن الطبيب',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.selectedText,
            ),
          ),
        ),
        HeightSpace(8.h),
        Text(
          doctor.bio,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.selectedText,
          ),
        ),
      ],
    );
  }
}
