// lib/features/doctor_side/doctor_home/presentation/widgets/appointment_list_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_appointment_status.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_today_appointment_entity.dart';

class AppointmentListItem extends StatelessWidget {
  final DoctorTodayAppointmentEntity appointment;
  final VoidCallback? onTap;

  const AppointmentListItem({super.key, required this.appointment, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _AppointmentCardShell(
        borderColor: _resolveBorderColor(appointment.status),
        child: Row(
          children: [
            AppointmentPatientAvatar(name: appointment.patientName),
            const WidthSpace(12),
            Expanded(child: AppointmentInfoColumn(appointment: appointment)),
            AppointmentStatusChip(status: appointment.status),
          ],
        ),
      ),
    );
  }

  Color _resolveBorderColor(DoctorAppointmentStatus status) {
    switch (status) {
      case DoctorAppointmentStatus.cancelled:
        return AppColors.error;
      case DoctorAppointmentStatus.confirmed:
        return AppColors.primary;
      case DoctorAppointmentStatus.completed:
        return AppColors.success;
      case DoctorAppointmentStatus.pending:
        return AppColors.warning;
    }
  }
}

class _AppointmentCardShell extends StatelessWidget {
  final Color borderColor;
  final Widget child;

  const _AppointmentCardShell({required this.borderColor, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          right: BorderSide(color: borderColor, width: 4.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class AppointmentPatientAvatar extends StatelessWidget {
  final String name;

  const AppointmentPatientAvatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        color: Color(0xFFDBEAFE),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name.characters.first : '؟',
          style: AppTypography.bodymid.copyWith(
            color: AppColors.primary,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

class AppointmentInfoColumn extends StatelessWidget {
  final DoctorTodayAppointmentEntity appointment;

  const AppointmentInfoColumn({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppointmentPatientName(name: appointment.patientName),
        const HeightSpace(3),
        AppointmentSubtitle(
          time: appointment.time,
          isNewPatient: appointment.isNewPatient,
        ),
      ],
    );
  }
}

class AppointmentPatientName extends StatelessWidget {
  final String name;

  const AppointmentPatientName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: AppTypography.bodymid.copyWith(
        color: AppColors.selectedText,
        fontSize: 14.sp,
      ),
    );
  }
}

class AppointmentSubtitle extends StatelessWidget {
  final String time;
  final bool isNewPatient;

  const AppointmentSubtitle({
    super.key,
    required this.time,
    required this.isNewPatient,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = isNewPatient ? 'مستخدم جديد • $time' : time;
    return Text(
      subtitle,
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// Status chip — rounded pill
class AppointmentStatusChip extends StatelessWidget {
  final DoctorAppointmentStatus status;

  const AppointmentStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _resolveConfig(status);
    return _StatusChipShell(config: config);
  }

  _StatusChipConfig _resolveConfig(DoctorAppointmentStatus status) {
    switch (status) {
      case DoctorAppointmentStatus.cancelled:
        return _StatusChipConfig(
          label: 'ملغي',
          bg: AppColors.redWhite,
          fg: AppColors.error,
        );
      case DoctorAppointmentStatus.confirmed:
        return _StatusChipConfig(
          label: 'مؤكد',
          bg: AppColors.greenWhite,
          fg: AppColors.success,
        );
      case DoctorAppointmentStatus.completed:
        return _StatusChipConfig(
          label: 'مكتمل',
          bg: AppColors.greenWhite,
          fg: AppColors.success,
        );
      case DoctorAppointmentStatus.pending:
        return _StatusChipConfig(
          label: 'قيد الانتظار',
          bg: const Color(0xFFFEF9C3),
          fg: const Color(0xFF92400E),
        );
    }
  }
}

class _StatusChipShell extends StatelessWidget {
  final _StatusChipConfig config;

  const _StatusChipShell({required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: config.bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        config.label,
        style: AppTypography.bodySmall.copyWith(
          color: config.fg,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StatusChipConfig {
  final String label;
  final Color bg;
  final Color fg;
  const _StatusChipConfig({
    required this.label,
    required this.bg,
    required this.fg,
  });
}
