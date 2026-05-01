// lib/features/doctor_side/doctor_home/presentation/widgets/today_schedule_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_today_appointment_entity.dart';
import 'appointment_list_item.dart';
import 'doctor_section_header.dart';

class TodayScheduleSection extends StatelessWidget {
  final List<DoctorTodayAppointmentEntity> appointments;
  final VoidCallback? onViewAll;

  const TodayScheduleSection({
    super.key,
    required this.appointments,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DoctorSectionHeader(
          title: 'جدول اليوم',
          trailing: ViewAllLink(onTap: onViewAll),
        ),
        const HeightSpace(12),
        appointments.isEmpty
            ? const _EmptyScheduleWidget()
            : _ScheduleList(appointments: appointments),
      ],
    );
  }
}

class _ScheduleList extends StatelessWidget {
  final List<DoctorTodayAppointmentEntity> appointments;

  const _ScheduleList({required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (_, i) => AppointmentListItem(appointment: appointments[i]),
    );
  }
}

class _EmptyScheduleWidget extends StatelessWidget {
  const _EmptyScheduleWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: AppColors.textDisabled,
              size: 40.sp,
            ),
            const HeightSpace(8),
            Text(
              'لا توجد مواعيد اليوم',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}