import 'package:flutter/material.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/small_card.dart';

class ClassifyFilesSerach extends StatelessWidget {
  const ClassifyFilesSerach({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SmallCard(
            title: "الكل",
            hightPadding: 8,
            widthPadding: 20,
            onTap: () {},
          ),
          WidthSpace(12),
          SmallCard(
            title: "تحاليل",
            hightPadding: 8,
            widthPadding: 20,
            onTap: () {},
          ),
          WidthSpace(12),
          SmallCard(
            title: "اشعة",
            hightPadding: 8,
            widthPadding: 20,
            onTap: () {},
          ),
          WidthSpace(12),
          SmallCard(
            title: "تقارير",
            hightPadding: 8,
            widthPadding: 20,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
