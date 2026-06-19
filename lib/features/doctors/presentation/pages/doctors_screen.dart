import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/di/injection_container.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/doctors/presentation/bloc/doctors_cubit.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/app_bar/doctors_app_bar.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctors_list_view.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DoctorsCubit>()..loadDoctors(),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.backGround,
          appBar: DoctorsAppBar(
            onSearch: (query) {
              // context موجود لأن BlocProvider فوق
            },
          ),
          body: const DoctorsListView(),
        ),
      ),
    );
  }
}