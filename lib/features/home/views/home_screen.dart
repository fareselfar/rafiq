import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SafeArea(child: SingleChildScrollView()),
    );
  }
}
