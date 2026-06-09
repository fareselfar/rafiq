import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/enums/doctor_availability.dart'; // مهم جداً
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';
import 'doctor_header.dart';
import 'doctor_location_and_status.dart';
import 'doctor_action_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class DoctorCard extends StatelessWidget {
  final DoctorsModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final bool isAvailable =
        doctor.availability == DoctorAvailability.availableNow;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 23.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF468EEC).withOpacity(0.25),
            blurRadius: 4.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          DoctorHeader(doctor: doctor),
          const HeightSpace(8),
          DoctorAvailabilitySection(
            address: doctor.address,
            isAvailable: isAvailable,
          ),
          const HeightSpace(8),
          DoctorActionButton(isAvailable: isAvailable, doctor: doctor),
        ],
      ),
    );
  }
}
