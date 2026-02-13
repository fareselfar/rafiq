import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/bookings/data/models/payment_arguments.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_app_bar.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_calendar_picker.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_date_selector.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_selection_header.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_time_slots_grid.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/booking_confirmation_bar.dart';
import 'package:rafiq/features/bookings/presentation/widgets/booking_appointment_widgets/doctor_brief_info.dart.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';

class BookAppointmentScreen extends StatefulWidget {
  final DoctorsEntity doctor;
  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const BookingAppBar(title: "حجز موعد"),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorBriefInfo(doctor: widget.doctor),
            const HeightSpace(20),

            BookingSelectionHeader(selectedDate: selectedDate),

            BookingDateSelector(
              selectedDate: selectedDate,
              onDateSelected: (date) => setState(() => selectedDate = date),
            ),

            const HeightSpace(12),
            BookingCalendarPicker(
              initialDate: selectedDate,
              onDateSelected: (date) {
                setState(() => selectedDate = date);
              },
            ),

            const HeightSpace(24),
            Text(
              'المواعيد المتاحة',
              style: AppTypography.doctorName.copyWith(fontSize: 16.sp),
            ),
            const HeightSpace(12),

            BookingTimeSlotsGrid(
              selectedTimeSlot: selectedTimeSlot,
              onTimeSelected: (time) => setState(() => selectedTimeSlot = time),
            ),

            const HeightSpace(30),

            const HeightSpace(20),
          ],
        ),
      ),

      bottomNavigationBar: BookingConfirmationBar(
        selectedDate: selectedDate,
        selectedTime: selectedTimeSlot,
        onConfirm: () {
          if (selectedTimeSlot != null) {
            context.navigateTo(
              Routes.paymentScreen,
              arguments: PaymentArguments(
                doctor: widget.doctor,
                date: selectedDate,
                time: selectedTimeSlot!,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('يرجى اختيار وقت أولاً')),
            );
          }
        },
      ),
    );
  }
}
