import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/domain/entities/doctor_appointments_entity.dart';

import 'duration_selector.dart';

class EditSlotDialog extends StatefulWidget {
  final AppointmentSlotEntity slot;
  final void Function(
    DateTime newDateTime,
    int duration,
  ) onConfirm;

  const EditSlotDialog({
    super.key,
    required this.slot,
    required this.onConfirm,
  });

  @override
  State<EditSlotDialog> createState() => _EditSlotDialogState();
}

class _EditSlotDialogState extends State<EditSlotDialog> {
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Text(
        'تعديل الموعد',
        style: AppTypography.dialogTitle,
      ),
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

          Text(
            'مدة الموعد: $_duration دقيقة',
            style: AppTypography.bodySmall,
          ),

          const HeightSpace(8),

          DurationSelector(
            duration: _duration,
            onChanged: (value) {
              setState(() {
                _duration = value;
              });
            },
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
          onPressed: () {
            widget.onConfirm(
              _selectedDateTime,
              _duration,
            );
          },
          child: Text(
            'تأكيد',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}