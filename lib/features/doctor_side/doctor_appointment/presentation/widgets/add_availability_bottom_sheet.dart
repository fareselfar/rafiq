import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class AddAvailabilityBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final void Function(DateTime date, TimeOfDay from, TimeOfDay to) onConfirm;

  const AddAvailabilityBottomSheet({
    super.key,
    required this.initialDate,
    required this.onConfirm,
  });

  @override
  State<AddAvailabilityBottomSheet> createState() => _AddAvailabilityBottomSheetState();
}

class _AddAvailabilityBottomSheetState extends State<AddAvailabilityBottomSheet> {
  late DateTime _selectedDate;
  TimeOfDay _fromTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _toTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  bool get _isValid {
    final fromMins = _fromTime.hour * 60 + _fromTime.minute;
    final toMins = _toTime.hour * 60 + _toTime.minute;
    return toMins > fromMins;
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
    final m = t.minute.toString().padLeft(2, '0');
    final period = t.hour < 12 ? 'ص' : 'م';
    return '$h:$m $period';
  }

  String _formatDate(DateTime d) {
    const months = ['', 'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    return '${d.day} ${months[d.month]} ${d.year}';
  }

  Future<void> _showPicker(Widget child) async {
    await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.primary)),
        child: child!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.h, left: 16.w, right: 16.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r)),
            ),
          ),
          const HeightSpace(16),
          Text('إضافة موعد متاح', style: AppTypography.profileServicesStyle),
          const HeightSpace(20),

          _buildPickerRow(Icons.calendar_today_outlined, 'التاريخ', _formatDate(_selectedDate), () async {
            final picked = await showDatePicker(
              context: context, initialDate: _selectedDate,
              firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) setState(() => _selectedDate = picked);
          }),
          const HeightSpace(12),

          _buildPickerRow(Icons.access_time_rounded, 'من', _formatTime(_fromTime), () async {
            final picked = await showTimePicker(context: context, initialTime: _fromTime);
            if (picked != null) {
              setState(() {
                _fromTime = picked;
                final totalMinutes = picked.hour * 60 + picked.minute + 30;
                _toTime = TimeOfDay(hour: (totalMinutes ~/ 60) % 24, minute: totalMinutes % 60);
              });
            }
          }),
          const HeightSpace(12),

          _buildPickerRow(Icons.access_time_filled_rounded, 'إلى', _formatTime(_toTime), () async {
            final picked = await showTimePicker(context: context, initialTime: _toTime);
            if (picked != null) setState(() => _toTime = picked);
          }),
          const HeightSpace(8),

          if (!_isValid)
            Text(
              'وقت الانتهاء يجب أن يكون بعد وقت البداية',
              style: AppTypography.bodySmall.copyWith(color: AppColors.error, fontSize: 12.sp),
            ),
          const HeightSpace(16),

          CustomButton(
            text: 'تأكيد الإضافة',
            onPressed: _isValid ? () {
              Navigator.pop(context);
              widget.onConfirm(_selectedDate, _fromTime, _toTime);
            } : null,
            type: ButtonType.filled,
            width: double.infinity,
            backgroundColor: AppColors.primary,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildPickerRow(IconData icon, String label, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.backGround,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20.sp),
            const WidthSpace(10),
            Text(label, style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary, fontSize: 13.sp)),
            const Spacer(),
            Text(value, style: AppTypography.bodymid.copyWith(color: AppColors.selectedText, fontWeight: FontWeight.w600, fontSize: 14.sp)),
            const WidthSpace(6),
            Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}