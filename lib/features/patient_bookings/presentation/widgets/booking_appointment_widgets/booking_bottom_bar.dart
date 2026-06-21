import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/book_appointment_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_confirmation_bar.dart';

class BookingBottomBar
    extends StatelessWidget {
  final int doctorId;
  final DateTime selectedDate;
  final String? selectedTime;

  const BookingBottomBar({
    super.key,
    required this.doctorId,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
        BookAppointmentCubit,
        BookAppointmentState>(
      builder: (context, state) {
        final cubit =
            context.read<
                BookAppointmentCubit>();

        return BookingConfirmationBar(
          selectedDate: selectedDate,
          selectedTime: selectedTime,
          isLoading:
              state is BookingInProgress,
          onConfirm: () {
            if (cubit.selectedSlotId !=
                null) {
              cubit.confirmBooking(
                doctorId,
              );
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(
                const SnackBar(
                  content: Text(
                    'يرجى اختيار وقت أولاً',
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}