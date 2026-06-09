// lib/features/doctor_side/doctor_appointments/presentation/cubit/doctor_appointments_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/doctor_appointments_entity.dart';
import '../../domain/usecases/doctor_appointments_usecases.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  final GetWeeklyScheduleUsecase getWeeklySchedule;
  final CancelFullDayUsecase cancelFullDay;
  final EditSlotUsecase editSlot;
  final CancelSlotUsecase cancelSlot;

  final String doctorId;

  DoctorAppointmentsCubit({
    required this.getWeeklySchedule,
    required this.cancelFullDay,
    required this.editSlot,
    required this.cancelSlot,
    required this.doctorId,
  }) : super(const DoctorAppointmentsInitial());

  // ── Helpers ────────────────────────────────────────────────────────────────

  DoctorAppointmentsLoaded? get _loaded =>
      state is DoctorAppointmentsLoaded ? state as DoctorAppointmentsLoaded : null;

  /// Monday of the week containing [date]
  DateTime _weekStart(DateTime date) {
    final diff = date.weekday - DateTime.monday;
    final monday = date.subtract(Duration(days: diff));
    return DateTime(monday.year, monday.month, monday.day);
  }

  // ── Load ───────────────────────────────────────────────────────────────────

  Future<void> loadSchedule({DateTime? initialDay}) async {
    final today = initialDay ?? DateTime.now();
    emit(const DoctorAppointmentsLoading());

    final result = await getWeeklySchedule(
      doctorId: doctorId,
      weekStart: _weekStart(today),
    );

    result.fold(
      (f) => emit(DoctorAppointmentsError(f.message)),
      (schedule) => emit(DoctorAppointmentsLoaded(
        schedule: schedule,
        selectedDay: today,
      )),
    );
  }

  // ── Week navigation ────────────────────────────────────────────────────────

  Future<void> goToPreviousWeek() async {
    final loaded = _loaded;
    if (loaded == null) return;

    final newWeekStart = loaded.schedule.weekStart.subtract(const Duration(days: 7));
    await _fetchWeek(newWeekStart, loaded.selectedDay.subtract(const Duration(days: 7)));
  }

  Future<void> goToNextWeek() async {
    final loaded = _loaded;
    if (loaded == null) return;

    final newWeekStart = loaded.schedule.weekStart.add(const Duration(days: 7));
    await _fetchWeek(newWeekStart, loaded.selectedDay.add(const Duration(days: 7)));
  }

  Future<void> _fetchWeek(DateTime weekStart, DateTime newSelectedDay) async {
    emit(const DoctorAppointmentsLoading());

    final result = await getWeeklySchedule(
      doctorId: doctorId,
      weekStart: weekStart,
    );

    result.fold(
      (f) => emit(DoctorAppointmentsError(f.message)),
      (schedule) => emit(DoctorAppointmentsLoaded(
        schedule: schedule,
        selectedDay: newSelectedDay,
      )),
    );
  }

  // ── Day selection ──────────────────────────────────────────────────────────

  void selectDay(DateTime day) {
    final loaded = _loaded;
    if (loaded == null) return;
    emit(loaded.copyWith(selectedDay: day, clearSelectedSlot: true));
  }

  // ── Slot selection ─────────────────────────────────────────────────────────

  void selectSlot(AppointmentSlotEntity slot) {
    final loaded = _loaded;
    if (loaded == null) return;
    // Toggle: tap same slot again to deselect
    final isSame = loaded.selectedSlot?.id == slot.id;
    emit(loaded.copyWith(
      selectedSlot: isSame ? null : slot,
      clearSelectedSlot: isSame,
    ));
  }

  void clearSelectedSlot() {
    final loaded = _loaded;
    if (loaded == null) return;
    emit(loaded.copyWith(clearSelectedSlot: true));
  }

  // ── Cancel full day ────────────────────────────────────────────────────────

  Future<void> cancelDay() async {
    final loaded = _loaded;
    if (loaded == null) return;

    emit(loaded.copyWith(isCancellingDay: true));

    final result = await cancelFullDay(
      doctorId: doctorId,
      day: loaded.selectedDay,
    );

    result.fold(
      (f) => emit(DoctorAppointmentsError(f.message)),
      (_) {
        emit(const DoctorAppointmentsActionSuccess('تم إلغاء اليوم بنجاح'));
        // Reload same week
        loadSchedule(initialDay: loaded.selectedDay);
      },
    );
  }

  // ── Cancel single slot ─────────────────────────────────────────────────────

  Future<void> cancelSelectedSlot() async {
    final loaded = _loaded;
    if (loaded == null || loaded.selectedSlot == null) return;

    emit(loaded.copyWith(isSlotActionLoading: true));

    final result = await cancelSlot(slotId: loaded.selectedSlot!.id);

    result.fold(
      (f) => emit(DoctorAppointmentsError(f.message)),
      (_) {
        emit(const DoctorAppointmentsActionSuccess('تم إلغاء الموعد بنجاح'));
        loadSchedule(initialDay: loaded.selectedDay);
      },
    );
  }

  // ── Edit single slot ───────────────────────────────────────────────────────

  Future<void> editSelectedSlot({
    required DateTime newDateTime,
    required int newDurationMinutes,
  }) async {
    final loaded = _loaded;
    if (loaded == null || loaded.selectedSlot == null) return;

    emit(loaded.copyWith(isSlotActionLoading: true));

    final result = await editSlot(
      slotId: loaded.selectedSlot!.id,
      newDateTime: newDateTime,
      newDurationMinutes: newDurationMinutes,
    );

    result.fold(
      (f) => emit(DoctorAppointmentsError(f.message)),
      (_) {
        emit(const DoctorAppointmentsActionSuccess('تم تعديل الموعد بنجاح'));
        loadSchedule(initialDay: loaded.selectedDay);
      },
    );
  }
}
