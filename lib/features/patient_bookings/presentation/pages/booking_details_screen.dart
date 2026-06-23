import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/injection_container.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_state.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_app_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_details/booking_details_actions.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_details/booking_details_gridviow.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_details/booking_doctor_details_card.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_details/booking_status.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_details/booking_details_shimmer.dart';

class BookingDetailsScreen extends StatelessWidget {
  final int appointmentId;

  const BookingDetailsScreen({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppointmentsCubit>()..loadDetails(appointmentId),
      child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          if (state is CancelSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم إلغاء الحجز بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is ActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is AppointmentDetailsLoading;
          final details = state is AppointmentDetailsLoaded
              ? state.details
              : null;

          return Scaffold(
            backgroundColor: AppColors.backGround,
            appBar: const BookingAppBar(title: 'تفاصيل الحجز'),

            body: SafeArea(
              child: isLoading
                  ? const BookingDetailsShimmerBody()
                  : (details != null
                        ? SingleChildScrollView(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 20.h,
                            ),
                            child: Column(
                              children: [
                                BookingDoctorDetailsCard(details: details),
                                const HeightSpace(20),
                                const HeightSpace(20),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "تفاصيل الحجز",
                                    style: AppTypography.inputLabel.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const HeightSpace(8),
                                BookingDetailsGridView(details: details),
                                const HeightSpace(20),
                                // PaymentBillSummary(details: details),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              state is AppointmentsError
                                  ? state.message
                                  : "حدث خطأ ما",
                            ),
                          )),
            ),

            bottomNavigationBar: isLoading
                ? const BookingActionsShimmer()
                : (details != null
                      ? BookingDetailsActions(details: details)
                      : const SizedBox.shrink()),
          );
        },
      ),
    );
  }
}
