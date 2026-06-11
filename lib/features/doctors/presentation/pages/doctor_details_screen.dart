import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_alert_box.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_info_section.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_professional_files.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_working_hours.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorsEntity doctor;
  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    bool isAvailable = doctor.availability == DoctorAvailability.availableNow;

    return Scaffold(
      appBar: AppBar(title: const Text('ملف الطبيب'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            HeightSpace(20.h),
            DoctorInfoSection(doctor: doctor),
            HeightSpace(24.h),
            DoctorWorkingHours(workingHours: doctor.workingHours),
            HeightSpace(24.h),
            const DoctorAlertBox(),
            HeightSpace(24.h),
            const DoctorProfessionalFiles(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        color: Colors.white,
        child: CustomButton(
          text: isAvailable ? 'احجز الآن' : 'غير متاح حالياً',
          onPressed: isAvailable
              ? () {
                  final booking = BookingEntity(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    doctor: doctor,
                    date: DateTime.now().add(const Duration(days: 1)),
                    time: '',
                    subTotal: doctor.consultationPrice.toDouble(),
                    discount: 0,
                    status: BookingStatus.upcoming,
                  );
                  context.navigateTo(
                    Routes.bookAppointmentScreen,
                    arguments: booking,
                  );
                }
              : null,
          backgroundColor: isAvailable
              ? AppColors.primary
              : const Color(0xFFD9D9D9),
        ),
      ),
    );
  }
}
