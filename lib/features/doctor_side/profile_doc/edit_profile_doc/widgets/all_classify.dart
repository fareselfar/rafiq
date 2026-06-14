import 'package:flutter/material.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/classify_tratement.dart';

class AllClassify extends StatelessWidget {
  const AllClassify({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClassifyTratement(title: "الكل", isSelected: true),
        ClassifyTratement(title: "هذا الاسبوع"),
        ClassifyTratement(title: "هذا الشهر"),
      ],
    );
  }
}
