import 'package:flutter/material.dart';
import 'package:rafiq/features/articles/data/models/articles_model.dart';
import 'package:rafiq/features/patient_side/patient_profile/presentation/widgets/small_card.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.article,
    required this.bgcolor,
    required this.fgcolor,
  });
  final ArticlesModel article;
  final Color bgcolor;
  final Color fgcolor;

  @override
  Widget build(BuildContext context) {
    return SmallCard(
      isList: false,
      bgColor: bgcolor,
      fgColor: fgcolor,
      title: article.category,
      hightPadding: 6,
      widthPadding: 18,
      onTap: () {},
    );
  }
}
