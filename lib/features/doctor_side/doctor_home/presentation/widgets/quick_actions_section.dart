// lib/features/doctor_side/doctor_home/presentation/widgets/quick_actions_section.dart

import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'doctor_section_header.dart';

class QuickActionsSection extends StatelessWidget {
  final VoidCallback? onCreateCoupon;
  final VoidCallback? onShareProfile;

  const QuickActionsSection({
    super.key,
    this.onCreateCoupon,
    this.onShareProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DoctorSectionHeader(title: 'إجراءات سريعة'),
        const HeightSpace(14),
        _CreateCouponButton(onPressed: onCreateCoupon),
        const HeightSpace(10),
        _ShareProfileButton(onPressed: onShareProfile),
      ],
    );
  }
}

class _CreateCouponButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _CreateCouponButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'انشاء كوبون خصم',
      onPressed: onPressed,
      type: ButtonType.outlined,
      width: double.infinity,
      borderColor: AppColors.selectedDoctor,
      borderRadius: 12,
      textStyle: TextStyle(
        color: AppColors.selectedDoctor,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ShareProfileButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _ShareProfileButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'مشاركة الملف الشخصي',
      onPressed: onPressed,
      type: ButtonType.outlined,
      width: double.infinity,
      borderColor: AppColors.warning,
      borderRadius: 12,
      textStyle: TextStyle(
        color: AppColors.warning,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}