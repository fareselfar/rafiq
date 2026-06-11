import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';
import '../widgets/success_widgets/success_header.dart';
import '../widgets/success_widgets/success_doctor_card.dart';
import '../widgets/success_widgets/booking_details_grid.dart';
import '../widgets/success_widgets/success_actions.dart';

class BookingSuccessScreen extends StatelessWidget {
  final BookingEntity booking;
  final DateTime selectedDate;
  final String selectedTime;

  const BookingSuccessScreen({
    super.key,
    required this.booking,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              const SuccessHeader(),

              const HeightSpace(20),
              SuccessDoctorCard(booking: booking),

              const HeightSpace(30),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "تفاصيل الحجز",
                  style: AppTypography.inputLabel.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const HeightSpace(8),
              BookingDetailsGrid(date: selectedDate, time: selectedTime),

              const HeightSpace(20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SuccessActions(),
    );
  }
}
