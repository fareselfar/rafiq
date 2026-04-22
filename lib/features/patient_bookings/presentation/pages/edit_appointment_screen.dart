import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/success_update_dialog.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_app_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_calendar_picker.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_date_selector.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_selection_header.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_time_slots_grid.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_confirmation_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/doctor_brief_info.dart.dart';

class EditAppointmentScreen extends StatefulWidget {
  final BookingEntity booking;
  const EditAppointmentScreen({super.key, required this.booking});

  @override
  State<EditAppointmentScreen> createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.booking.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: const BookingAppBar(title: "تعديل الحجز"),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DoctorBriefInfo(booking: widget.booking),
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
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const SuccessUpdateDialog(),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('يرجى اختيار وقت أولاً')),
            );
          }
        },
        buttonText: "تأكيد التعديل",
      ),
    );
  }
}
