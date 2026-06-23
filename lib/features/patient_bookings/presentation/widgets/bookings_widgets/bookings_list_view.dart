import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_state.dart';
import 'booking_card.dart';

class BookingsListView extends StatelessWidget {
  const BookingsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsCubit, AppointmentsState>(
      builder: (context, state) {
        if (state is AppointmentsLoading) {
          return const _AppointmentsShimmer();
        } 
        
        if (state is AppointmentsLoaded) {
          final appointments = state.appointments;

          if (appointments.isEmpty) {
            return Center(
              child: Text("لا توجد حجوزات حالياً", style: AppTypography.bodyLarge),
            );
          }

          return ListView.builder(
            itemCount: appointments.length,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemBuilder: (context, index) => BookingCard(appointment: appointments[index]),
          );
        } 
        
        if (state is AppointmentsError) {
          return Center(
            child: Text(state.message, style: AppTypography.bodyLarge),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _AppointmentsShimmer extends StatelessWidget {
  const _AppointmentsShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (_, _) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          height: 140.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
      ),
    );
  }
}