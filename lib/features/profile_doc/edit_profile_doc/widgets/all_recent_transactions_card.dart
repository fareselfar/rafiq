import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile_doc/edit_profile_doc/widgets/recent_transactions_card.dart';

class AllRecentTransactionsCard extends StatelessWidget {
  const AllRecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecentTransactionsCard(
          title1: "تحويل أرباح دوري",
          title2: "20 أكتوبر 2023",
          title3: "تحويل بنكي",
          transTitle: "مكتمل",
          price: "2000 جنيه",
          bgSpecialCard: AppColors.hintStyle,
          fgSpecialCard: AppColors.oil,
        ),
        HeightSpace(16),
        RecentTransactionsCard(
          title1: "تحويل أرباح دوري",
          title2: "20 أكتوبر 2023",
          title3: "تحويل بنكي",
          transTitle: "مكتمل",
          price: "2000 جنيه",
          bgSpecialCard: AppColors.hintStyle,
          fgSpecialCard: AppColors.oil,
        ),
        HeightSpace(16),
        RecentTransactionsCard(
          title1: "تحويل أرباح دوري",
          title2: "20 أكتوبر 2023",
          title3: "تحويل بنكي",
          transTitle: "مكتمل",
          price: "2000 جنيه",
          bgSpecialCard: AppColors.hintStyle,
          fgSpecialCard: AppColors.oil,
        ),
      ],
    );
  }
}
