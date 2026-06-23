// lib/features/doctor_side/doctor_appointments/presentation/cubit/doctor_appointments_cubit.dart

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/doctor_appointments_entity.dart';
import '../../domain/usecases/doctor_appointments_usecases.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  final GetWeeklyScheduleUsecase getWeeklySchedule;
  final CancelFullDayUsecase cancelFullDay;
  final EditSlotUsecase editSlot;
  final CancelSlotUsecase cancelSlot;
  final AddAvailabilityUsecase addAvailability;

  final String doctorId;

  DoctorAppointmentsCubit({
    required this.getWeeklySchedule,
    required this.cancelFullDay,
    required this.editSlot,
    required this.cancelSlot,
    required this.addAvailability,
    required this.doctorId,
  }) : super(const DoctorAppointmentsInitial());

  // ── Helpers ────────────────────────────────────────────────────────────────

  DoctorAppointmentsLoaded? get _loaded => state is DoctorAppointmentsLoaded
      ? state as DoctorAppointmentsLoaded
      : null;

  /// حساب بداية الـ Window (يومين قبل اليوم المختار) لتوسيط اليوم الحالي
  DateTime _calculateWindowStart(DateTime date) {
    final target = date.subtract(const Duration(days: 2));
    return DateTime(target.year, target.month, target.day);
  }

  /// Monday of the week containing [date] (للسيرفر فقط لأن السيرفر يحتاج بداية أسبوع)
  DateTime _weekStart(DateTime date) {
    final diff = date.weekday - DateTime.monday;
    final monday = date.subtract(Duration(days: diff));
    return DateTime(monday.year, monday.month, monday.day);
  }

  // ── Load ───────────────────────────────────────────────────────────────────

  Future<void> loadSchedule({DateTime? initialDay, DateTime? customWindowStart}) async {
    final today = initialDay ?? DateTime.now();
    emit(const DoctorAppointmentsLoading());

    // السيرفر يحتاج الـ weekStart لجلب البيانات، لكن الـ UI سيعرض الـ Window
    final result = await getWeeklySchedule(
      doctorId: doctorId,
      weekStart: _weekStart(today),
    );

    result.fold(
      (f) => emit(DoctorAppointmentsError(f.message)),
      (schedule) {
        // إذا لم نرسل windowStart مخصص، نحسبه تلقائياً ليتم توسيط اليوم
        final calculatedWindow = customWindowStart ?? _calculateWindowStart(today);
        emit(
          DoctorAppointmentsLoaded(
            schedule: schedule, 
            selectedDay: today,
            windowStart: calculatedWindow, // تم حل المشكلة هنا بتمرير القيمة الابتدائية
          ),
        );
      },
    );
  }

  // ── Window navigation (Shift Window) ───────────────────────────────────────

  Future<void> goToPreviousWindow() async {
    final loaded = _loaded;
    if (loaded == null) return;

    // تحريك النافذة 7 أيام للخلف
    final newWindowStart = loaded.windowStart.subtract(const Duration(days: 7));
    
    // إذا كان اليوم المختار ما زال داخل النافذة الجديدة، نحتفظ به، وإلا نختار أول يوم في النافذة الجديدة
    DateTime newSelected = loaded.selectedDay;
    final windowEnd = newWindowStart.add(const Duration(days: 8));
    if (newSelected.isBefore(newWindowStart) || newSelected.isAfter(windowEnd)) {
      newSelected = newWindowStart.add(const Duration(days: 2)); // نضع الاختيار على ثالث يوم بالنافذة الجديدة
    }

    await _fetchWindow(newWindowStart, newSelected);
  }

  Future<void> goToNextWindow() async {
    final loaded = _loaded;
    if (loaded == null) return;

    // تحريك النافذة 7 أيام للأمام
    final newWindowStart = loaded.windowStart.add(const Duration(days: 7));
    
    // التحقق من بقاء اليوم المختار داخل النافذة
    DateTime newSelected = loaded.selectedDay;
    final windowEnd = newWindowStart.add(const Duration(days: 8));
    if (newSelected.isBefore(newWindowStart) || newSelected.isAfter(windowEnd)) {
      newSelected = newWindowStart.add(const Duration(days: 2));
    }

    await _fetchWindow(newWindowStart, newSelected);
  }

  Future<void> _fetchWindow(DateTime targetWindowStart, DateTime newSelectedDay) async {
    emit(const DoctorAppointmentsLoading());

    final result = await getWeeklySchedule(
      doctorId: doctorId,
      weekStart: _weekStart(newSelectedDay),
    );

    result.fold(
      (f) => emit(DoctorAppointmentsError(f.message)),
      (schedule) => emit(
        DoctorAppointmentsLoaded(
          schedule: schedule,
          selectedDay: newSelectedDay,
          windowStart: targetWindowStart,
        ),
      ),
    );
  }

  // ── Day selection ──────────────────────────────────────────────────────────

  void selectDay(DateTime day) {
    final loaded = _loaded;
    if (loaded == null) return;

    DateTime currentWindowStart = loaded.windowStart;
    final windowEnd = currentWindowStart.add(const Duration(days: 8));

    // لو المستخدم اختار يوم خارج الـ Window المعروضة حالياً، نقوم بتحريك الـ Window تلقائياً
    if (day.isBefore(currentWindowStart) || day.isAfter(windowEnd)) {
      currentWindowStart = _calculateWindowStart(day);
      // نقوم بإعادة التحميل لتحديث بيانات السيرفر لليوم الجديد والـ Window الجديدة
      loadSchedule(initialDay: day, customWindowStart: currentWindowStart);
    } else {
      // اليوم داخل الـ Window الحالية، نغير الاختيار فقط بدون إعادة تحميل من السيرفر
      emit(loaded.copyWith(selectedDay: day, clearSelectedSlot: true));
    }
  }

  // ── Remaining actions remain unchanged ─────────────────────────────────────
  void selectSlot(AppointmentSlotEntity slot) {
    final loaded = _loaded;
    if (loaded == null) return;
    final isSame = loaded.selectedSlot?.id == slot.id;
    emit(loaded.copyWith(selectedSlot: isSame ? null : slot, clearSelectedSlot: isSame));
  }

  void clearSelectedSlot() {
    final loaded = _loaded;
    if (loaded == null) return;
    emit(loaded.copyWith(clearSelectedSlot: true));
  }

  Future<void> cancelDay() async {
    final loaded = _loaded;
    if (loaded == null) return;
    emit(loaded.copyWith(isCancellingDay: true));
    final result = await cancelFullDay(doctorId: doctorId, day: loaded.selectedDay);
    result.fold((f) => emit(DoctorAppointmentsError(f.message)), (_) {
      emit(const DoctorAppointmentsActionSuccess('تم إلغاء اليوم بنجاح'));
      loadSchedule(initialDay: loaded.selectedDay, customWindowStart: loaded.windowStart);
    });
  }

  Future<void> cancelSelectedSlot() async {
    final loaded = _loaded;
    if (loaded == null || loaded.selectedSlot == null) return;
    emit(loaded.copyWith(isSlotActionLoading: true));
    final result = await cancelSlot(slotId: loaded.selectedSlot!.id);
    result.fold((f) => emit(DoctorAppointmentsError(f.message)), (_) {
      emit(const DoctorAppointmentsActionSuccess('تم إلغاء الموعد بنجاح'));
      loadSchedule(initialDay: loaded.selectedDay, customWindowStart: loaded.windowStart);
    });
  }

  Future<void> editSelectedSlot({required DateTime newDateTime, required int newDurationMinutes}) async {
    final loaded = _loaded;
    if (loaded == null || loaded.selectedSlot == null) return;
    emit(loaded.copyWith(isSlotActionLoading: true));
    final result = await editSlot(slotId: loaded.selectedSlot!.id, newDateTime: newDateTime, newDurationMinutes: newDurationMinutes);
    result.fold((f) => emit(DoctorAppointmentsError(f.message)), (_) {
      emit(const DoctorAppointmentsActionSuccess('تم تعديل الموعد بنجاح'));
      loadSchedule(initialDay: loaded.selectedDay, customWindowStart: loaded.windowStart);
    });
  }

  Future<void> addNewAvailability({required DateTime date, required TimeOfDay from, required TimeOfDay to}) async {
    final loaded = _loaded;
    if (loaded == null) return;
    emit(loaded.copyWith(isSlotActionLoading: true));
    final result = await addAvailability(date: date, from: from, to: to);
    result.fold((f) => emit(DoctorAppointmentsError(f.message)), (_) {
      emit(const DoctorAppointmentsActionSuccess('تم إضافة الموعد بنجاح'));
      loadSchedule(initialDay: date);
    });
  }
}