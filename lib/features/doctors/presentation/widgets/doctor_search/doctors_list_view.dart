import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/doctors/presentation/bloc/doctors_cubit.dart';
import 'doctor_card/doctor_card.dart';

class DoctorsListView extends StatelessWidget {
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        if (state is DoctorsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message, style: AppTypography.bodyLarge),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<DoctorsCubit>().loadDoctors(),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        if (state is DoctorsLoaded) {
          if (state.doctors.isEmpty) {
            return Center(
              child: Text('لا يوجد أطباء متاحون', style: AppTypography.bodyLarge),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.only(top: 8.h, bottom: 20.h),
            itemCount: state.doctors.length,
            itemBuilder: (context, index) {
              return DoctorCard(doctor: state.doctors[index]);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}