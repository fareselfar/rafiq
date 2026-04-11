import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile_doc/edit_profile_doc/widgets/profits_widget.dart';

class AllProfits extends StatelessWidget {
  const AllProfits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfitsWidget(
          icon: SvgManger.profits,
          title1: "أرباح هذا الشهر",
          title2: "12,000 جنيه",
        ),
        HeightSpace(8),
        ProfitsWidget(
          icon: SvgManger.money,
          title1: "إجمالي الأرباح",
          title2: "20,000 جنيه",
        ),
        HeightSpace(8),
        ProfitsWidget(
          icon: SvgManger.timer,
          title1: "آخر تحويل",
          title2: "5,000 جنيه",
        ),
        HeightSpace(8),
        ProfitsWidget(
          icon: SvgManger.info,
          title1: "عدد العمليات",
          title2: "80 عملية",
        ),
      ],
    );
  }
}
