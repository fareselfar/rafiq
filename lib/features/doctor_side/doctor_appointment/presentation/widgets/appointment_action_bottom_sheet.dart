import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import '../../domain/entities/doctor_appointments_entity.dart';

class AppointmentActionBottomSheet extends StatelessWidget {
  final AppointmentSlotEntity slot;
  final VoidCallback onEdit;
  final VoidCallback onCancel;

  const AppointmentActionBottomSheet({
    super.key,
    required this.slot,
    required this.onEdit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final String timeLabel = slot.dateTime.hour >= 12 
        ? "${slot.dateTime.hour == 12 ? 12 : slot.dateTime.hour - 12}:${slot.dateTime.minute.toString().padLeft(2, '0')} م"
        : "${slot.dateTime.hour == 0 ? 12 : slot.dateTime.hour}:${slot.dateTime.minute.toString().padLeft(2, '0')} ص";
        
    final String dateLabel = DateFormat('d MMMM', 'ar').format(slot.dateTime);

    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'الموعد المحدد ',
                style: AppTypography.doctorName.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.selectedText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const WidthSpace(8),
              Text(
                '$timeLabel - $dateLabel',
                style: AppTypography.bodymid.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          const HeightSpace(16),
          
          // زرار تعديل الموعد الأزرق
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: CustomButton(
              text: 'تعديل الموعد',
              onPressed: onEdit,
              type: ButtonType.filled,
              backgroundColor: AppColors.primary,
              borderRadius: 10,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const HeightSpace(10),
          
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFBA1A1A), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                slot.isBooked ? 'إلغاء حجز المريض' : 'إلغاء الموعد (إغلاق الفترة)',
                style: TextStyle(
                  color: const Color(0xFFBA1A1A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}