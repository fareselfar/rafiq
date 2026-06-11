import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_side/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_app_bar.dart';
import 'package:rafiq/features/patient_side/patient_bookings/presentation/widgets/booking_details/booking_details_actions.dart';
import 'package:rafiq/features/patient_side/patient_bookings/presentation/widgets/booking_details/booking_details_gridviow.dart';
import 'package:rafiq/features/patient_side/patient_bookings/presentation/widgets/booking_details/booking_status.dart';
import 'package:rafiq/features/patient_side/patient_bookings/presentation/widgets/payment_widgets/payment_bill_summary.dart';
import '../widgets/success_widgets/success_doctor_card.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: BookingAppBar(title: 'تفاصيل الحجز'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              SuccessDoctorCard(booking: booking),

              const HeightSpace(20),
              BookingStatus(booking: booking),
              const HeightSpace(20),
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
              BookingDetailsGridViow(booking: booking),

              const HeightSpace(20),
              PaymentBillSummary(booking: booking),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BookingDetailsActions(booking: booking),
    );
  }
}
