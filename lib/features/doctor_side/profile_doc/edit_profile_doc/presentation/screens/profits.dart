import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/all_classify.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/all_profits.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/all_recent_transactions_card.dart';

class ProfitsScrren extends StatelessWidget {
  const ProfitsScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تعديل بيانات الدفع",
          style: AppTypography.appBarTitelStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                "عرض وإدارة سجل المعاملات المالية والمستحقات",
                style: AppTypography.inputTextFormStyle,
              ),
              HeightSpace(20),
              AllProfits(),
              HeightSpace(20),
              CustomSearchField(
                hint: "ابحث في المعاملات...",
                suffixIcon: Icon(Icons.search),
              ),
              HeightSpace(25),
              AllClassify(),
              HeightSpace(16),
              Text("المعاملات الاخيرة", style: AppTypography.subTitelStyle),
              HeightSpace(16),
              AllRecentTransactionsCard(),
              HeightSpace(16),
              CustomButton(onPressed: () {}, text: "عرض المزيد"),
              HeightSpace(40),
            ],
          ),
        ),
      ),
    );
  }
}
