// lib/features/doctor_side/doctor_appointments/presentation/widgets/day_action_buttons.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import './doctor_appointments_calendar_picker.dart';

class DayActionButtons extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback? onCancelFullDay;
  final bool isCancelLoading;

  const DayActionButtons({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.onCancelFullDay,
    this.isCancelLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          DoctorAppointmentsCalendarPicker(
            selectedDate: selectedDate,
            onDateSelected: onDateSelected,
          ),
          const HeightSpace(10),
          CustomButton(
            text: 'إلغاء يوم كامل',
            onPressed: onCancelFullDay,
            type: ButtonType.outlined,
            isLoading: isCancelLoading,
            width: double.infinity,
            borderColor: AppColors.error,
            borderRadius: 10,
            textStyle: TextStyle(
              color: AppColors.error,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}