import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_availability_extension.dart';

class CustomDoctorContainer extends StatelessWidget {
  final DoctorsEntity doctor;

  const CustomDoctorContainer({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // مهم جداً
        children: [
          /// TOP
          Row(
            children: [
              CircleAvatar(
                radius: 32.r,
                backgroundImage: doctor.imageUrl.startsWith('http')
                    ? NetworkImage(doctor.imageUrl)
                    : AssetImage(doctor.imageUrl) as ImageProvider,
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textLabel,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      doctor.specialization,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Icon(Icons.star, size: 18.sp, color: Colors.amber),
                  SizedBox(width: 2.w),
                  Text(
                    doctor.rating.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8.h),

          /// LOCATION + STATUS
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: AppColors.selectedText,
              ),

              SizedBox(width: 4.w),

              Expanded(
                child: Text(
                  doctor.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.selectedText,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: doctor.availability.color.withOpacity(.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  doctor.availability.text,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: doctor.availability.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// BUTTON
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'احجز الآن',
              height: 40.h,
              onPressed: () {
                context.navigateTo(
                  Routes.doctorDetailsScreen,
                  arguments: doctor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
