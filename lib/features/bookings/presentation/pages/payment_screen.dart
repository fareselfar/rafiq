import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/bookings/data/models/payment_arguments.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_app_bar.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_confirmation_bar.dart';
import 'package:rafiq/features/bookings/presentation/widgets/payment_widgets/notice_box.dart';
import 'package:rafiq/features/bookings/presentation/widgets/payment_widgets/payment_bill_summary.dart';
import 'package:rafiq/features/bookings/presentation/widgets/payment_widgets/payment_doctor_card.dart';
import 'package:rafiq/features/bookings/presentation/widgets/payment_widgets/payment_methods_section.dart';
import 'package:rafiq/features/bookings/presentation/widgets/payment_widgets/payment_promo_field.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class PaymentScreen extends StatelessWidget {
  final DoctorsEntity doctor;
  final DateTime selectedDate;
  final String selectedTime;

  const PaymentScreen({
    super.key,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,

      appBar: const BookingAppBar(title: "الدفع"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            PaymentDoctorCard(
              doctor: doctor,
              date: selectedDate,
              time: selectedTime,
            ),
            const HeightSpace(18),

            NoticeBox(),
            const HeightSpace(20),
            const PaymentMethodsSection(),

            const HeightSpace(20),
            const PaymentPromoField(),

            const HeightSpace(20),
            const PaymentBillSummary(),
          ],
        ),
      ),

      bottomNavigationBar: BookingConfirmationBar(
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        onConfirm: () {
          context.navigateTo(
            Routes.bookingSuccessScreen,
            arguments: PaymentArguments(
              doctor: doctor,
              date: selectedDate,
              time: selectedTime,
            ),
          );
        },
      ),
    );
  }
}
