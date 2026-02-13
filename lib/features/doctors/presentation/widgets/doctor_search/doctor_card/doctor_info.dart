import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';

class DoctorInfo extends StatelessWidget {
  final DoctorsModel doctor;

  const DoctorInfo({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doctor.name,
            style: AppTypography.profileNameStyle.copyWith(fontSize: 14.sp),
          ),
          HeightSpace(8),
          Text(
            doctor.specialization,
            style: AppTypography.profileServiceNameStyle.copyWith(
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
