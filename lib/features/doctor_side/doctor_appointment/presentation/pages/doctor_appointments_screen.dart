// lib/features/doctor_side/doctor_appointments/presentation/pages/doctor_appointments_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/injection_container.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/bloc/doctor_appointments_cubit.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/widgets/add_availability_bottom_sheet.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/widgets/doctor_appointment_app_bar.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/widgets/edit_slot_dialog.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/widgets/week_date_picker.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/widgets/week_navigator.dart';
import '../../domain/entities/doctor_appointments_entity.dart';
import '../widgets/appointments_top_bar.dart';
import '../widgets/day_action_buttons.dart';
import '../widgets/day_slots_list.dart';

class DoctorAppointmentsScreen extends StatelessWidget {
  final String doctorId;
  final String doctorName;

  const DoctorAppointmentsScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorAppointmentsCubit(
        getWeeklySchedule: sl(),
        cancelFullDay: sl(),
        editSlot: sl(),
        cancelSlot: sl(),
        addAvailability: sl(),
        doctorId: doctorId,
      )..loadSchedule(),
      child: SafeArea(child: _DoctorAppointmentsView(doctorName: doctorName)),
    );
  }
}

class _DoctorAppointmentsView extends StatelessWidget {
  final String doctorName;
  const _DoctorAppointmentsView({required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SafeArea(
        child: BlocConsumer<DoctorAppointmentsCubit, DoctorAppointmentsState>(
          listener: _handleStateChange,
          builder: (context, state) {
            if (state is DoctorAppointmentsLoading ||
                state is DoctorAppointmentsInitial) {
              return const _LoadingView();
            }
            if (state is DoctorAppointmentsError) {
              return _ErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<DoctorAppointmentsCubit>().loadSchedule(),
              );
            }
            if (state is DoctorAppointmentsLoaded) {
              return _ContentView(state: state, doctorName: doctorName);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _handleStateChange(BuildContext context, DoctorAppointmentsState state) {
    if (state is DoctorAppointmentsActionSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    if (state is DoctorAppointmentsError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// ─── Content ──────────────────────────────────────────────────────────────────

class _ContentView extends StatelessWidget {
  final DoctorAppointmentsLoaded state;
  final String doctorName;

  const _ContentView({required this.state, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorAppointmentsCubit>();
    final slotsForDay = state.schedule.slotsForDay(state.selectedDay);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => cubit.loadSchedule(initialDay: state.selectedDay),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DoctorAppointmentAppBar(
            //   doctorName: doctorName,
            //   onNotificationTap: () {},
            //   onAvatarTap: () {},
            // ),
            AppointmentsTopBar(
              onAddAppointment: () => _showAddAvailability(context, cubit),
            ),
            const HeightSpace(16),
            WeekNavigator(
              onPrevious: cubit.goToPreviousWindow,
              onNext: cubit.goToNextWindow,
            ),
            const HeightSpace(16),
            WeekDatePicker(
              windowStart: state.windowStart,
              selectedDay: state.selectedDay,
              onDaySelected: cubit.selectDay,
            ),
            const HeightSpace(16),
            DayActionButtons(
              selectedDate: state.selectedDay,
              onDateSelected: cubit.selectDay,
              onCancelFullDay: cubit.cancelDay,
              isCancelLoading: state.isCancellingDay,
            ),
            const HeightSpace(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: DaySlotsListWidget(
                slots: slotsForDay,
                selectedSlot: state.selectedSlot,
                onSlotTap: cubit.selectSlot,
                onEditSlot: state.selectedSlot != null
                    ? () => _showEditDialog(context, state.selectedSlot!, cubit)
                    : null,
                onCancelSlot: cubit.cancelSelectedSlot,
                isSlotActionLoading: state.isSlotActionLoading,
              ),
            ),
            const HeightSpace(32),
          ],
        ),
      ),
    );
  }

  void _showAddAvailability(
    BuildContext context,
    DoctorAppointmentsCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddAvailabilityBottomSheet(
        initialDate: state.selectedDay,
        onConfirm: (date, from, to) =>
            cubit.addNewAvailability(date: date, from: from, to: to),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    AppointmentSlotEntity slot,
    DoctorAppointmentsCubit cubit,
  ) {
    showDialog(
      context: context,
      builder: (_) => EditSlotDialog(
        slot: slot,
        onConfirm: (newDateTime, duration) {
          Navigator.pop(context);
          cubit.editSelectedSlot(
            newDateTime: newDateTime,
            newDurationMinutes: duration,
          );
        },
      ),
    );
  }
}

// ─── Loading ──────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 56.sp,
            ),
            const HeightSpace(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const HeightSpace(20),
            CustomButton(
              text: 'إعادة المحاولة',
              onPressed: onRetry,
              backgroundColor: AppColors.primary,
              borderRadius: 12,
              width: 180.w,
              height: 44.h,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
