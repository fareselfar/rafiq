import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class BookingsTabBar extends StatelessWidget implements PreferredSizeWidget {
  const BookingsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: AppColors.primary,
      indicatorWeight: 3,
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.unSelectedText,
      labelStyle: AppTypography.bodyLarge,
      tabs: const [
        Tab(text: "الكل"),
        Tab(text: "القادمة"),
        Tab(text: "المكتملة"),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
