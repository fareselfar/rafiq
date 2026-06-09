// lib/features/doctor_side/doctor_appointments/presentation/pages/doctor_appointments_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/data/repositories/doctor_appointment_repository_impl.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/bloc/doctor_appointments_cubit.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/widgets/doctor_appointment_app_bar.dart';
import '../../data/datasources/doctor_appointments_datasource.dart';
import '../../domain/entities/doctor_appointments_entity.dart';
import '../../domain/usecases/doctor_appointments_usecases.dart';
import '../widgets/appointments_top_bar.dart';
import '../widgets/day_action_buttons.dart';
import '../widgets/day_slots_list.dart';
import '../widgets/week_date_picker.dart';
import '../widgets/week_navigator.dart';

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
      create: (_) {
        final datasource = DoctorAppointmentsMockDatasource();
        final repo = DoctorAppointmentsRepositoryImpl(datasource);
        return DoctorAppointmentsCubit(
          getWeeklySchedule: GetWeeklyScheduleUsecase(repo),
          cancelFullDay: CancelFullDayUsecase(repo),
          editSlot: EditSlotUsecase(repo),
          cancelSlot: CancelSlotUsecase(repo),
          doctorId: doctorId,
        )..loadSchedule();
      },
      child: _DoctorAppointmentsView(doctorName: doctorName),
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
          listener: (context, state) {
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
          },
          builder: (context, state) {
            if (state is DoctorAppointmentsLoading ||
                state is DoctorAppointmentsInitial) {
              return const _AppointmentsLoadingView();
            }
            if (state is DoctorAppointmentsError) {
              return _AppointmentsErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<DoctorAppointmentsCubit>().loadSchedule(),
              );
            }
            if (state is DoctorAppointmentsLoaded) {
              return _AppointmentsContentView(
                state: state,
                doctorName: doctorName,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// ─── Content ──────────────────────────────────────────────────────────────────

class _AppointmentsContentView extends StatelessWidget {
  final DoctorAppointmentsLoaded state;
  final String doctorName;

  const _AppointmentsContentView({
    required this.state,
    required this.doctorName,
  });

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
            DoctorAppointmentAppBar(
              doctorName: doctorName,
              onNotificationTap: () {},
              onAvatarTap: () {},
            ),

            // ── Top bar ──
            AppointmentsTopBar(onAddAppointment: () {}),

            const HeightSpace(16),

            // ── Week navigator ──
            WeekNavigator(
              weekStart: state.schedule.weekStart,
              onPrevious: cubit.goToPreviousWeek,
              onNext: cubit.goToNextWeek,
            ),

            const HeightSpace(16),

            // ── Date picker strip ──
            WeekDatePicker(
              weekStart: state.schedule.weekStart,
              selectedDay: state.selectedDay,
              onDaySelected: cubit.selectDay,
            ),

            const HeightSpace(16),

            // ── Day action buttons ──
            DayActionButtons(
              selectedDate: state.selectedDay,
              onDateSelected: cubit.selectDay,
              onCancelFullDay: cubit.cancelDay,
              isCancelLoading: state.isCancellingDay,
            ),

            const HeightSpace(16),

            // ── Slots list ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: DaySlotsListWidget(
                slots: slotsForDay,
                selectedSlot: state.selectedSlot,
                onSlotTap: cubit.selectSlot,
                onEditSlot: () {
                  _showEditDialog(context, state.selectedSlot!, cubit);
                },
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

  void _showEditDialog(
    BuildContext context,
    AppointmentSlotEntity slot,
    DoctorAppointmentsCubit cubit,
  ) {
    showDialog(
      context: context,
      builder: (_) => _EditSlotDialog(
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

// ─── Edit Dialog ──────────────────────────────────────────────────────────────

class _EditSlotDialog extends StatefulWidget {
  final AppointmentSlotEntity slot;
  final void Function(DateTime newDateTime, int duration) onConfirm;

  const _EditSlotDialog({required this.slot, required this.onConfirm});

  @override
  State<_EditSlotDialog> createState() => _EditSlotDialogState();
}

class _EditSlotDialogState extends State<_EditSlotDialog> {
  late DateTime _selectedDateTime;
  late int _duration;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.slot.dateTime;
    _duration = widget.slot.durationMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text('تعديل الموعد', style: AppTypography.dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الموعد الحالي: ${widget.slot.timeLabel} - ${widget.slot.dateLabel}',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const HeightSpace(16),
          Text('مدة الموعد: $_duration دقيقة', style: AppTypography.bodySmall),
          const HeightSpace(8),
          _DurationSelector(
            duration: _duration,
            onChanged: (v) => setState(() => _duration = v),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'إلغاء',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () => widget.onConfirm(_selectedDateTime, _duration),
          child: Text(
            'تأكيد',
            style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _DurationSelector extends StatelessWidget {
  final int duration;
  final ValueChanged<int> onChanged;

  const _DurationSelector({required this.duration, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [15, 30, 45, 60].map((d) {
        final selected = duration == d;
        return GestureDetector(
          onTap: () => onChanged(d),
          child: Container(
            margin: EdgeInsets.only(left: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: selected ? AppColors.primary : AppColors.border,
              ),
            ),
            child: Text(
              '$d د',
              style: AppTypography.bodySmall.copyWith(
                color: selected ? Colors.white : AppColors.textSecondary,
                fontSize: 12.sp,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Loading ──────────────────────────────────────────────────────────────────

class _AppointmentsLoadingView extends StatelessWidget {
  const _AppointmentsLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primary),
    );
  }
}

// ─── Error ────────────────────────────────────────────────────────────────────

class _AppointmentsErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _AppointmentsErrorView({required this.message, required this.onRetry});

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
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'إعادة المحاولة',
                  style: AppTypography.bodymid.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
