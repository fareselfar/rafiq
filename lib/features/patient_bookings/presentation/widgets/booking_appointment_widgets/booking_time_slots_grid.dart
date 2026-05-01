import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class BookingTimeSlotsGrid extends StatelessWidget {
  final String? selectedTimeSlot;
  final Function(String) onTimeSelected;

  const BookingTimeSlotsGrid({
    super.key,
    required this.selectedTimeSlot,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> slots = [
      "09:00 ص",
      "09:15 ص",
      "09:30 ص",
      "09:45 ص",
      "10:00 ص",
      "10:30 ص",
      "04:00 م",
      "04:15 م",
      "04:30 م",
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        bool isSelected = selectedTimeSlot == slots[index];
        bool isBooked = index == 0 || index == 3 || index == 8;

        return GestureDetector(
          onTap: isBooked ? null : () => onTimeSelected(slots[index]),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isBooked
                  ? Colors.grey.shade200
                  : (isSelected ? AppColors.primary : Colors.white),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
              ),
            ),
            child: Text(
              slots[index],
              style: AppTypography.bodySmall.copyWith(
                color: isBooked
                    ? Colors.grey
                    : (isSelected ? Colors.white : Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
