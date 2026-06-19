import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/slot_entity.dart';

class BookingTimeSlotsGrid extends StatelessWidget {
  final List<SlotEntity> slots;
  final int? selectedSlotId;
  final Function(SlotEntity) onSlotSelected;

  const BookingTimeSlotsGrid({
    super.key,
    required this.slots,
    this.selectedSlotId,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Text(
            'لا توجد مواعيد متاحة في هذا اليوم',
            style: AppTypography.bodyLarge,
          ),
        ),
      );
    }

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
        final slotItem = slots[index]; 
        final bool isSelected = slotItem.id == selectedSlotId;
        final bool isBooked = slotItem.isReserved;

        return GestureDetector(
          onTap: isBooked ? null : () => onSlotSelected(slotItem),
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
              slotItem.time,
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