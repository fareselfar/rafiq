import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/app_bar/doctors_app_bar.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctors_list_view.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.backGround,
          appBar: DoctorsAppBar(),
          body: DoctorsListView(),
        ),
      ),
    );
  }
}
