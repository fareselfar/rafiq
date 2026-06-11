import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';

class CancelReasonDialog extends StatefulWidget {
  const CancelReasonDialog({super.key});

  @override
  State<CancelReasonDialog> createState() => _CancelReasonDialogState();
}

class _CancelReasonDialogState extends State<CancelReasonDialog> {
  String? selectedReason;
  final List<String> reasons = [
    "أريد تغيير الموعد",
    "حجزت بالخطأ",
    "الموقع بعيد جداً",
    "أسباب أخرى",
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text("سبب إلغاء الحجز", style: AppTypography.dialogTitle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: reasons
              .map(
                (reason) => RadioListTile<String>(
                  title: Text(reason, style: AppTypography.bodySmall),
                  value: reason,
                  groupValue: selectedReason,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => selectedReason = val),
                ),
              )
              .toList(),
        ),
        actions: [
          CustomButton(
            text: "تأكيد الإلغاء",
            onPressed: selectedReason == null
                ? null
                : () {
                    Navigator.pop(context);
                    // اظهر ديالوج النجاح
                  },
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
