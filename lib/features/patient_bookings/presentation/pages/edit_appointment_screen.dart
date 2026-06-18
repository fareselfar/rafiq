// lib/features/patient_bookings/presentation/pages/edit_appointment_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/injection_container.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/success_update_dialog.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/slot_entity.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_state.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/book_appointment_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_app_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_calendar_picker.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_confirmation_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_date_selector.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_selection_header.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_time_slots_grid.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/doctor_brief_info.dart.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_shimmer/booking_appointment_shimmer_body.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_shimmer/booking_bottom_bar_shimmer.dart';

class EditAppointmentScreen extends StatelessWidget {
  final int appointmentId;
  final BookingArgs args;

  const EditAppointmentScreen({
    super.key,
    required this.appointmentId,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<BookAppointmentCubit>()
            ..loadSlots(
              args.doctorId,
              DateTime.now().add(const Duration(days: 1)),
            ),
        ),
        BlocProvider.value(value: sl<AppointmentsCubit>()),
      ],
      child: _EditAppointmentView(
        appointmentId: appointmentId,
        args: args,
      ),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _EditAppointmentView extends StatelessWidget {
  final int appointmentId;
  final BookingArgs args;

  const _EditAppointmentView({
    required this.appointmentId,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentsCubit, AppointmentsState>(
      listener: _handleRescheduleState,
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: const BookingAppBar(title: 'تعديل الحجز'),
        body: BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
          builder: (context, slotsState) {
            if (slotsState is SlotsLoading ||
                slotsState is BookAppointmentInitial) {
              return const BookingAppointmentShimmerBody();
            }
            if (slotsState is BookAppointmentError) {
              return _ErrorView(
                message: slotsState.message,
                onRetry: () {
                  context.read<BookAppointmentCubit>().loadSlots(
                        args.doctorId,
                        context.read<BookAppointmentCubit>().selectedDate,
                      );
                },
              );
            }
            if (slotsState is SlotsLoaded) {
              return _SlotsBody(
                args: args,
                slots: slotsState.slots,
                selectedSlotId: slotsState.selectedSlotId,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar:
            BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
          builder: (context, slotsState) {
            if (slotsState is SlotsLoading ||
                slotsState is BookAppointmentInitial) {
              return const BookingBottomBarShimmer();
            }

            final cubit = context.read<BookAppointmentCubit>();
            final appointmentsCubit = context.read<AppointmentsCubit>();

            SlotEntity? selectedSlot;
            if (slotsState is SlotsLoaded && slotsState.selectedSlotId != null) {
              try {
                selectedSlot = slotsState.slots.firstWhere(
                  (s) => s.id == slotsState.selectedSlotId,
                );
              } catch (_) {}
            }

            return BlocBuilder<AppointmentsCubit, AppointmentsState>(
              builder: (context, rescheduleState) {
                final isLoading = rescheduleState is RescheduleInProgress;
                return BookingConfirmationBar(
                  selectedDate: cubit.selectedDate,
                  selectedTime: selectedSlot?.time,
                  isLoading: isLoading,
                  onConfirm: selectedSlot != null && !isLoading
                      ? () => appointmentsCubit.rescheduleAppointment(
                            appointmentId,
                            selectedSlot!.id,
                          )
                      : null,
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _handleRescheduleState(
      BuildContext context, AppointmentsState state) {
    if (state is RescheduleSuccess) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const SuccessUpdateDialog(),
      );
    }
    if (state is ActionError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}

// ─── Slots body ───────────────────────────────────────────────────────────────

class _SlotsBody extends StatelessWidget {
  final BookingArgs args;
  final List<SlotEntity> slots;
  final int? selectedSlotId;

  const _SlotsBody({
    required this.args,
    required this.slots,
    required this.selectedSlotId,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookAppointmentCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeightSpace(10),
          DoctorBriefInfo(booking: args),
          const HeightSpace(20),
          BookingSelectionHeader(selectedDate: cubit.selectedDate),
          BookingDateSelector(
            selectedDate: cubit.selectedDate,
            onDateSelected: (date) =>
                cubit.loadSlots(args.doctorId, date),
          ),
          const HeightSpace(12),
          BookingCalendarPicker(
            initialDate: cubit.selectedDate,
            onDateSelected: (date) => cubit.loadSlots(args.doctorId, date),
          ),
          const HeightSpace(24),
          Text(
            'المواعيد المتاحة',
            style: AppTypography.doctorName.copyWith(fontSize: 16.sp),
          ),
          const HeightSpace(12),
          BookingTimeSlotsGrid(
            slots: slots,
            selectedSlotId: selectedSlotId,
            onSlotSelected: (slot) => cubit.selectSlot(slot.id),
          ),
          const HeightSpace(120), 
        ],
      ),
    );
  }
}

// ─── Error ────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 48.sp),
          const HeightSpace(12),
          Text(message,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textSecondary)),
          const HeightSpace(16),
          TextButton(
            onPressed: onRetry,
            child: Text('إعادة المحاولة',
                style:
                    AppTypography.bodymid.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}