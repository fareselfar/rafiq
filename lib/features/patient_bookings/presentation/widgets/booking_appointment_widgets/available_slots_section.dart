import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/slot_entity.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/book_appointment_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_time_slots_grid.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/slots_shimmer.dart';

class AvailableSlotsSection extends StatelessWidget {
  final Function(SlotEntity) onSlotSelected;

  const AvailableSlotsSection({
    super.key,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
      buildWhen: (previous, current) {
        return current is SlotsLoading ||
            current is SlotsLoaded ||
            current is BookAppointmentError;
      },
      builder: (context, state) {
        if (state is SlotsLoading) {
          return const SlotsShimmer();
        }

        if (state is SlotsLoaded) {
          return BookingTimeSlotsGrid(
            slots: state.slots,
            selectedSlotId: state.selectedSlotId,
            onSlotSelected: onSlotSelected,
          );
        }

        if (state is BookAppointmentError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(state.message),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}