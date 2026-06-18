// lib/features/patient_bookings/presentation/widgets/booking_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_state.dart';
import 'booking_doctor_header.dart';
import 'booking_info_section.dart';
import 'booking_action_buttons.dart';

class BookingCard extends StatelessWidget {
  final PatientAppointmentEntity appointment;

  const BookingCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        if (state is CancelSuccess) {
          Navigator.of(context, rootNavigator: true).pop(); // close dialog
          context.read<AppointmentsCubit>().loadAppointments();
        }
        if (state is ActionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 23.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 4.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingDoctorHeader(booking: appointment),
            const HeightSpace(8),
            if (appointment.status.toLowerCase() != 'cancelled') ...[
              BookingInfoSection(booking: appointment),
              const HeightSpace(8),
              BookingActionButtons(booking: appointment),
            ],
          ],
        ),
      ),
    );
  }
}