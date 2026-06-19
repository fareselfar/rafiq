import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/injection_container.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_alert_box.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_info_section.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_professional_files.dart';
import 'package:rafiq/features/doctors/presentation/widgets/profile_details/doctor_working_hours.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final int doctorId;
  const DoctorDetailsScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DoctorProfileCubit>()..loadProfile(doctorId),
      child: Scaffold(
        appBar: AppBar(title: const Text('ملف الطبيب'), centerTitle: true),
        body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DoctorProfileError) {
              return Center(child: Text(state.message));
            }
            if (state is DoctorProfileLoaded) {
              final p = state.profile;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    HeightSpace(20.h),
                    DoctorInfoSection(profile: p),
                    HeightSpace(24.h),
                    DoctorWorkingHours(schedule: p.weeklySchedule),
                    HeightSpace(24.h),
                    const DoctorAlertBox(),
                    HeightSpace(24.h),
                    const DoctorProfessionalFiles(),
                    HeightSpace(100.h), // space for bottom button
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
        bottomNavigationBar: _BottomBookButton(doctorId: doctorId),
      ),
    );
  }
}

class _BottomBookButton extends StatelessWidget {
  final int doctorId;
  const _BottomBookButton({required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        if (state is! DoctorProfileLoaded) return const SizedBox(height: 80);
        final p = state.profile;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          color: Colors.white,
          child: CustomButton(
            text: 'احجز الآن',
            onPressed: () {
              context.navigateTo(
                Routes.bookAppointmentScreen,
                arguments: BookingArgs(
                  doctorId: p.id,
                  doctorName: p.fullName,
                  specialization: p.specialization,
                  imagePath: p.imagePath,
                  price: p.price,
                  address: p.address,
                ),
              );
            },
          ),
        );
      },
    );
  }
}