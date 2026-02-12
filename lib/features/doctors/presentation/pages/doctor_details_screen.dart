import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_alert_box.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_info_section.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_professional_files.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_working_hours.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorsEntity doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ملف الطبيب'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            HeightSpace(20.h),
            DoctorInfoSection(doctor: doctor),
            HeightSpace(20.h),
            DoctorWorkingHours(workingHours: doctor.workingHours),
            HeightSpace(20.h),
            DoctorAlertBox(),
            HeightSpace(20.h),
            DoctorProfessionalFiles(),
            HeightSpace(100.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: CustomButton(
          text: 'احجز الآن',
          onPressed: () {},
          height: 50.h,
          width: 328.w,
        ),
      ),
    );
  }
}
