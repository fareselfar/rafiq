// lib/features/doctor_side/doctor_appointments/presentation/widgets/day_slots_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import '../../domain/entities/doctor_appointments_entity.dart';
import 'appointment_slot_card.dart';

class DaySlotsListWidget extends StatefulWidget {
  final List<AppointmentSlotEntity> slots;
  final AppointmentSlotEntity? selectedSlot;
  final ValueChanged<AppointmentSlotEntity> onSlotTap;
  final VoidCallback? onEditSlot;
  final VoidCallback? onCancelSlot;
  final bool isSlotActionLoading;

  const DaySlotsListWidget({
    super.key,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotTap,
    this.onEditSlot,
    this.onCancelSlot,
    this.isSlotActionLoading = false,
  });

  @override
  State<DaySlotsListWidget> createState() => _DaySlotsListWidgetState();
}

class _DaySlotsListWidgetState extends State<DaySlotsListWidget> {
  static const int _initialCount = 4;
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    if (widget.slots.isEmpty) return const _EmptySlotsWidget();

    final displayedSlots =
        _showAll ? widget.slots : widget.slots.take(_initialCount).toList();
    final hasMore = widget.slots.length > _initialCount;

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayedSlots.length,
          itemBuilder: (_, i) {
            final slot = displayedSlots[i];
            final isSelected = widget.selectedSlot?.id == slot.id;
            return AppointmentSlotCard(
              slot: slot,
              isSelected: isSelected,
              onTap: () => widget.onSlotTap(slot),
              onEdit: isSelected ? widget.onEditSlot : null,
              onCancel: isSelected ? widget.onCancelSlot : null,
              isActionLoading: isSelected && widget.isSlotActionLoading,
            );
          },
        ),
        if (hasMore && !_showAll) _ShowMoreButton(onTap: () => setState(() => _showAll = true)),
      ],
    );
  }
}

class _ShowMoreButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ShowMoreButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Center(
          child: Text(
            'عرض المزيد',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptySlotsWidget extends StatelessWidget {
  const _EmptySlotsWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          children: [
            Icon(Icons.calendar_today_outlined,
                color: AppColors.textDisabled, size: 40.sp),
            const HeightSpace(8),
            Text(
              'لا توجد مواعيد في هذا اليوم',
              style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
