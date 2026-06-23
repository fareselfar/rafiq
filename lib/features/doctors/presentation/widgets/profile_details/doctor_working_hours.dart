// lib/features/doctors/presentation/widgets/profile_details/doctor_working_hours.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class DoctorWorkingHours extends StatelessWidget {
  final List<WeeklyScheduleEntity> schedule;

  const DoctorWorkingHours({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    if (schedule.isEmpty) return const SizedBox.shrink();

    const dayOrder = [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];

    final Map<String, _DayRange> grouped = {};

    for (final item in schedule) {
      if (item.isClosed) {
        grouped.putIfAbsent(
          item.dayName,
          () => _DayRange(dayName: item.dayName, isClosed: true),
        );
        continue;
      }

      final parts = item.timeRange.split(' - ');
      if (parts.length < 2) continue;

      final rawFrom = parts.first.trim();
      final rawTo = parts.last.trim();

      if (!grouped.containsKey(item.dayName)) {
        grouped[item.dayName] = _DayRange(
          dayName: item.dayName,
          isClosed: false,
          from: rawFrom,
          to: rawTo,
          fromMinutes: _toMinutes(rawFrom),
          toMinutes: _toMinutes(rawTo),
        );
      } else {
        final existing = grouped[item.dayName]!;
        final newToMins = _toMinutes(rawTo);
        final newFromMins = _toMinutes(rawFrom);

        grouped[item.dayName] = existing.copyWith(
          from: newFromMins < existing.fromMinutes ? rawFrom : existing.from,
          to: newToMins > existing.toMinutes ? rawTo : existing.to,
          fromMinutes: newFromMins < existing.fromMinutes
              ? newFromMins
              : existing.fromMinutes,
          toMinutes: newToMins > existing.toMinutes
              ? newToMins
              : existing.toMinutes,
        );
      }
    }

    final days = grouped.values.toList()
      ..sort((a, b) {
        final ai = dayOrder.indexOf(a.dayName);
        final bi = dayOrder.indexOf(b.dayName);
        return ai.compareTo(bi);
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text('مواعيد العمل', style: AppTypography.doctorName),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: days.map((day) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day.dayName,
                      style: AppTypography.profileServiceDetailsStyle,
                    ),
                    Text(
                      day.isClosed
                          ? 'مغلق'
                          : '${_formatDisplay(day.from)} - ${_formatDisplay(day.to)}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: day.isClosed ? Colors.red : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  int _toMinutes(String raw) {
    try {
      final cleaned = raw.trim();
      if (RegExp(r'^\d+:\d+:\d+$').hasMatch(cleaned)) {
        final parts = cleaned.split(':');
        return int.parse(parts[0]) * 60 + int.parse(parts[1]);
      }
      if (cleaned.contains('AM') || cleaned.contains('PM')) {
        final isPM = cleaned.contains('PM');
        final timePart = cleaned
            .replaceAll('AM', '')
            .replaceAll('PM', '')
            .trim();
        final parts = timePart.split(':');
        int hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        if (isPM && hour != 12) hour += 12;
        if (!isPM && hour == 12) hour = 0;
        return hour * 60 + minute;
      }
    } catch (_) {}
    return 0;
  }

  String _formatDisplay(String raw) {
    try {
      final cleaned = raw.trim();

      if (cleaned.contains('AM') ||
          cleaned.contains('PM') ||
          cleaned.contains('ص') ||
          cleaned.contains('م')) {
        return cleaned.replaceAll('AM', 'ص').replaceAll('PM', 'م').trim();
      }

      // format: "09:00:00"
      if (RegExp(r'^\d+:\d+').hasMatch(cleaned)) {
        final parts = cleaned.split(':');
        final hour = int.parse(parts[0]);
        final minute = parts[1];
        final suffix = hour < 12 ? 'ص' : 'م';
        final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
        return '$displayHour:$minute $suffix';
      }
    } catch (_) {}
    return raw;
  }
}

class _DayRange {
  final String dayName;
  final bool isClosed;
  final String from;
  final String to;
  final int fromMinutes;
  final int toMinutes;

  const _DayRange({
    required this.dayName,
    required this.isClosed,
    this.from = '',
    this.to = '',
    this.fromMinutes = 0,
    this.toMinutes = 0,
  });

  _DayRange copyWith({
    String? from,
    String? to,
    int? fromMinutes,
    int? toMinutes,
  }) {
    return _DayRange(
      dayName: dayName,
      isClosed: isClosed,
      from: from ?? this.from,
      to: to ?? this.to,
      fromMinutes: fromMinutes ?? this.fromMinutes,
      toMinutes: toMinutes ?? this.toMinutes,
    );
  }
}
