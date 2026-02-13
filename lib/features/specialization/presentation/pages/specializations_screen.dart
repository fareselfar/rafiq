import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/utils/assets_manger.dart';
import 'package:rafiq/features/specialization/data/models/specialization_model.dart';

import 'package:rafiq/features/specialization/presentation/widgets/specialization_widget.dart';

class SpecializationsScreen extends StatelessWidget {
  SpecializationsScreen({super.key});
  final List<SpecializationModel> specialization = [
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.dentistry,
      name: 'أسنان',
      numberOfDoctors: '50 طبيب',
    ),
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.internalMedicial,
      name: 'الباطنه',
      numberOfDoctors: '50 طبيب',
    ),
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.heart,
      name: 'قلب',
      numberOfDoctors: '50 طبيب',
    ),
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.children,
      name: 'أطفال',
      numberOfDoctors: '50 طبيب',
    ),
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.eye,
      name: 'رمد',
      numberOfDoctors: '50 طبيب',
    ),
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.nose,
      name: 'أنف وأذن',
      numberOfDoctors: '50 طبيب',
    ),
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.hand,
      name: 'جلدية',
      numberOfDoctors: '50 طبيب',
    ),
    SpecializationModel(
      onTap: () {},
      image: AssetsManger.famicons,
      name: 'نساء وتوليد',
      numberOfDoctors: '50 طبيب',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text('التخصصات'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .78,
        ),
        itemCount: specialization.length,
        itemBuilder: (context, index) =>
            SpecializationWidget(specializationModel: specialization[index]),
      ),
    );
  }
}
