import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/recent_transactions_card.dart';

class AllRecentTransactionsCard extends StatelessWidget {
  const AllRecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RecentTransactionsCard(
          icon: SvgManger.bank,
          title1: "تحويل أرباح دوري",
          title2: "20 أكتوبر 2023",
          title3: "تحويل بنكي",
          transTitle: "مكتمل",
          price: "2000 جنيه",
          bgSpecialCard: AppColors.notes,
          fgSpecialCard: AppColors.oil,
        ),
        HeightSpace(16),
        RecentTransactionsCard(
          icon: SvgManger.bank,
          title1: "تحويل أرباح دوري",
          title2: "20 أكتوبر 2023",
          title3: "تحويل بنكي",
          transTitle: "تم التحويل",
          price: "2000 جنيه",
          bgSpecialCard: AppColors.note,
          fgSpecialCard: AppColors.priceColor,
        ),
        HeightSpace(16),
        RecentTransactionsCard(
          icon: SvgManger.bank,
          title1: "تحويل أرباح دوري",
          title2: "20 أكتوبر 2023",
          title3: "تحويل بنكي",
          transTitle: "قيد المراجعة",
          price: "2000 جنيه",
          bgSpecialCard: AppColors.pinkPaymentProcessColor,
          fgSpecialCard: AppColors.redPaymentProcessColor,
        ),
      ],
    );
  }
}
