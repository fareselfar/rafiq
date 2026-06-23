// lib/features/patient_bookings/presentation/widgets/booking_details/booking_details_actions.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';

class BookingDetailsActions extends StatelessWidget {
  final AppointmentDetailsEntity details;

  const BookingDetailsActions({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (details.isUpcoming) ...[
            CustomButton(
              text: 'إعادة جدولة الحجز',
              onPressed: () => _navigateToEdit(context),
              width: size.width,
            ),
            const HeightSpace(12),
            CustomButton(
              text: 'إلغاء الحجز',
              onPressed: () => context
                  .read<AppointmentsCubit>()
                  .cancelAppointment(details.id),
              backgroundColor: AppColors.error,
              width: size.width,
            ),
          ] else ...[
            CustomButton(
              text: 'العودة إلى الرئيسية',
              onPressed: () =>
                  context.navigateAndRemoveUntil(Routes.patientHome),
              width: size.width,
            ),
            const HeightSpace(12),
            CustomButton(
              text: 'الانتقال الى حجوزاتي',
              onPressed: () => context.navigateAndRemoveUntil(
                Routes.patientHome,
                arguments: 3,
              ),
              type: ButtonType.outlined,
              width: size.width,
            ),
          ],
        ],
      ),
    );
  }

  void _navigateToEdit(BuildContext context) {
    context.navigateTo(
      Routes.editAppointmentScreen,
      arguments: {
        'appointmentId': details.id,
        'bookingArgs': BookingArgs(
          doctorId: details.doctorId,
          doctorName: details.doctorName,
          specialization: details.specialization,
          imagePath: details.imagePath,
          price: details.consultationPrice,
          address: details.location,
          rate: details.rate,
          reviewsCount: details.reviewsCount,
        ),
      },
    );
  }
}
