import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class BookingConfirmationBar extends StatelessWidget {
  final DateTime selectedDate;
  final String? selectedTime;
  final VoidCallback onConfirm;

  const BookingConfirmationBar({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onConfirm, 
    required String buttonText,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTime == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.only(
        top: 12.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الموعد المحدد',
                style: AppTypography.doctorName.copyWith(fontSize: 16.sp),
              ),
              Text(
                '$selectedTime - ${DateFormat('d MMMM', 'ar').format(selectedDate)}',
                style: AppTypography.bodymid.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          HeightSpace(12),
          SizedBox(
            width: double.infinity,
            child: CustomButton(text: 'تأكيد الحجز', onPressed: onConfirm),
          ),
        ],
      ),
    );
  }
}
