import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/patient_side/patient_bookings/presentation/widgets/bookings_widgets/bookings_tab_bar.dart';

class BookingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text("حجوزاتي", style: AppTypography.appBarTitelStyle),
      bottom: const BookingsTabBar(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(105.h);
}
