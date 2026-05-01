import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/boogings_app_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/bookings_view_body.dart';

class PatientBookingsScreen extends StatelessWidget {
  const PatientBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: BookingsAppBar(),
        body: BookingsViewBody(),
      ),
    );
  }
}
