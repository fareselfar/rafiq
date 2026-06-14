import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/small_card.dart';

class ClassifyTratement extends StatelessWidget {
  const ClassifyTratement({super.key, this.title, this.isSelected = false});
  final String? title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return SmallCard(
      isList: true,
      title: title ?? '',
      hightPadding: 8,
      widthPadding: 20,
      bgColor: isSelected ? AppColors.primary : AppColors.surface,
      fgColor: isSelected ? Colors.white : AppColors.textSecondary,
      onTap: () {},
    );
  }
}
