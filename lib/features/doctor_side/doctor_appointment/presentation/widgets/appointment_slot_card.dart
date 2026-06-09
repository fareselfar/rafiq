// lib/features/doctor_side/doctor_appointments/presentation/widgets/appointment_slot_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import '../../domain/entities/doctor_appointments_entity.dart';

class AppointmentSlotCard extends StatelessWidget {
  final AppointmentSlotEntity slot;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;
  final bool isActionLoading;

  const AppointmentSlotCard({
    super.key,
    required this.slot,
    required this.isSelected,
    required this.onTap,
    this.onEdit,
    this.onCancel,
    this.isActionLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SlotRow(slot: slot, isSelected: isSelected, onTap: onTap),
        if (isSelected && !slot.isBooked)
          _SlotActionPanel(
            slot: slot,
            onEdit: onEdit,
            onCancel: onCancel,
            isLoading: isActionLoading,
          ),
      ],
    );
  }
}

class _SlotRow extends StatelessWidget {
  final AppointmentSlotEntity slot;
  final bool isSelected;
  final VoidCallback onTap;

  const _SlotRow({
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightBlue : AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: isSelected
              ? Border.all(color: AppColors.primary, width: 1.5)
              : Border.all(color: AppColors.border.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(child: _SlotInfo(slot: slot)),
            const WidthSpace(8),
            _SlotTimeColumn(slot: slot),
            const WidthSpace(12),
            _SlotStatusChip(status: slot.status, isBooked: slot.isBooked),
          ],
        ),
      ),
    );
  }
}

class _SlotInfo extends StatelessWidget {
  final AppointmentSlotEntity slot;
  const _SlotInfo({required this.slot});

  @override
  Widget build(BuildContext context) {
    if (slot.isBooked && slot.patientName != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slot.patientName!,
            style: AppTypography.bodymid.copyWith(
              color: AppColors.selectedText,
              fontSize: 14.sp,
            ),
          ),
          const HeightSpace(2),
          Text(
            slot.visitType,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    }
    return Text(
      slot.visitType,
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontSize: 12.sp,
      ),
    );
  }
}

class _SlotTimeColumn extends StatelessWidget {
  final AppointmentSlotEntity slot;
  const _SlotTimeColumn({required this.slot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slot.timeLabel,
          style: AppTypography.bodymid.copyWith(
            color: AppColors.selectedText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const HeightSpace(2),
        Text(
          '${slot.durationMinutes} دقيقة',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _SlotStatusChip extends StatelessWidget {
  final DoctorAppointmentStatus status;
  final bool isBooked;

  const _SlotStatusChip({required this.status, required this.isBooked});

  @override
  Widget build(BuildContext context) {
    final config = _resolve();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
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

  _ChipConfig _resolve() {
    if (!isBooked) {
      return _ChipConfig(
        label: 'متاح',
        bg: AppColors.greenWhite,
        fg: AppColors.success,
      );
    }
    switch (status) {
      case DoctorAppointmentStatus.confirmed:
        return _ChipConfig(
          label: 'مؤكد',
          bg: AppColors.greenWhite,
          fg: AppColors.success,
        );
      case DoctorAppointmentStatus.pending:
        return _ChipConfig(
          label: 'قيد العمل',
          bg: AppColors.lightBlue,
          fg: AppColors.primary,
        );
      case DoctorAppointmentStatus.cancelled:
        return _ChipConfig(
          label: 'ملغي',
          bg: AppColors.redWhite,
          fg: AppColors.error,
        );
      case DoctorAppointmentStatus.completed:
        return _ChipConfig(
          label: 'مكتمل',
          bg: AppColors.greenWhite,
          fg: AppColors.success,
        );
    }
  }
}

class _ChipConfig {
  final String label;
  final Color bg;
  final Color fg;
  const _ChipConfig({required this.label, required this.bg, required this.fg});
}

class _SlotActionPanel extends StatelessWidget {
  final AppointmentSlotEntity slot;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;
  final bool isLoading;

  const _SlotActionPanel({
    required this.slot,
    this.onEdit,
    this.onCancel,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SelectedSlotLabel(slot: slot),
          const HeightSpace(12),
          _EditSlotButton(onPressed: onEdit, isLoading: isLoading),
          const HeightSpace(8),
          _CancelSlotButton(onPressed: onCancel, isLoading: isLoading),
        ],
      ),
    );
  }
}

class _SelectedSlotLabel extends StatelessWidget {
  final AppointmentSlotEntity slot;
  const _SelectedSlotLabel({required this.slot});

  @override
  Widget build(BuildContext context) {
    return Text(
      'الموعد المحدد: ${slot.timeLabel} - ${slot.dateLabel}',
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.textSecondary,
        fontSize: 13.sp,
      ),
    );
  }
}

class _EditSlotButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  const _EditSlotButton({this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'تعديل الموعد',
      onPressed: onPressed,
      type: ButtonType.filled,
      isLoading: isLoading,
      width: double.infinity,
      backgroundColor: AppColors.primary,
      borderRadius: 10,
      elevation: 0,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _CancelSlotButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  const _CancelSlotButton({this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'إلغاء الموعد',
      onPressed: onPressed,
      type: ButtonType.outlined,
      isLoading: isLoading,
      width: double.infinity,
      borderColor: AppColors.error,
      borderRadius: 10,
      textStyle: TextStyle(
        color: AppColors.error,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
