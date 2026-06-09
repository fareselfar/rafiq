// lib/features/doctor_side/doctor_appointments/presentation/widgets/day_action_buttons.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_appointment/presentation/widgets/cancel_day_button.dart';
import './doctor_appointments_calendar_picker.dart'; // تأكد من صحة مسار الاستيراد هنا بحسب مشروعك

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
          CancelDayButton(
            onPressed: onCancelFullDay,
            isLoading: isCancelLoading,
          ),
        ],
      ),
    );
  }
}