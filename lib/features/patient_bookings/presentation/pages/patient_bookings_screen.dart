// lib/features/patient_bookings/presentation/pages/patient_bookings_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/di/injection_container.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/boogings_app_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/bookings_view_body.dart';

class PatientBookingsScreen extends StatelessWidget {
  const PatientBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AppointmentsCubit>()..loadAppointments(),
      child: const DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.backGround,
          appBar: BookingsAppBar(),
          body: BookingsViewBody(),
        ),
      ),
    );
  }
}