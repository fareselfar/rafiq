// lib/features/patient_bookings/presentation/pages/book_appointment_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/available_slots_section.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_shimmer/booking_appointment_shimmer.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/booking_bottom_bar.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_appointment_widgets/doctor_brief_info.dart.dart';
import '../../../../core/routes/navigation_extension.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../../domain/entities/booking_result_args.dart';
import '../../domain/entities/bookings_entity.dart';
import '../bloc/book_appointment_cubit.dart';
import '../widgets/booking_appointment_widgets/booking_app_bar.dart';
import '../widgets/booking_appointment_widgets/booking_calendar_picker.dart';
import '../widgets/booking_appointment_widgets/booking_date_selector.dart';
import '../widgets/booking_appointment_widgets/booking_selection_header.dart';

class BookAppointmentScreen extends StatefulWidget {
  final BookingArgs args;

  const BookAppointmentScreen({super.key, required this.args});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  String? selectedSlotTime;

  static String getDayName(int weekday) {
    const days = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[weekday - 1];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookAppointmentCubit>().loadSlots(
        widget.args.doctorId,
        selectedDate,
      );
    });
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
      selectedSlotTime = null;
    });
    context.read<BookAppointmentCubit>().loadSlots(widget.args.doctorId, date);
  }

  void _handleBookingState(BuildContext context, BookAppointmentState state) {
    if (state is BookingSuccess) {
      context.navigateTo(
        Routes.bookingSuccessScreen,
        arguments: BookingResultArgs(
          appointmentId:
              context.read<BookAppointmentCubit>().selectedSlotId ?? 0,
          doctorName: widget.args.doctorName,
          specialization: widget.args.specialization,
          imagePath: widget.args.imagePath,
          rate: widget.args.rate,
          reviewsCount: widget.args.reviewsCount,
          date: DateFormat('d MMMM yyyy', 'ar').format(selectedDate),
          dayName: getDayName(selectedDate.weekday),
          time: selectedSlotTime ?? '',
          location: widget.args.address ?? '',
        ),
      );
    }

    if (state is BookAppointmentError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookAppointmentCubit, BookAppointmentState>(
      listener: _handleBookingState,
      child: BlocBuilder<BookAppointmentCubit, BookAppointmentState>(
        builder: (context, state) {
          final bool isLoading = state is SlotsLoading;

          return Scaffold(
            backgroundColor: AppColors.backGround,
            appBar: const BookingAppBar(title: 'حجز موعد'),
            body: SafeArea(
              child: isLoading
                  ? const BookingAppointmentShimmerBody()
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorBriefInfo(booking: widget.args),
                          const HeightSpace(20),
                          BookingSelectionHeader(selectedDate: selectedDate),
                          const HeightSpace(10),
                          BookingDateSelector(
                            selectedDate: selectedDate,
                            onDateSelected: _onDateChanged,
                          ),
                          const HeightSpace(12),
                          BookingCalendarPicker(
                            initialDate: selectedDate,
                            onDateSelected: _onDateChanged,
                          ),
                          const HeightSpace(24),
                          Text(
                            'المواعيد المتاحة',
                            style: AppTypography.doctorName.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          const HeightSpace(12),
                          AvailableSlotsSection(
                            onSlotSelected: (slot) {
                              setState(() => selectedSlotTime = slot.time);
                              context.read<BookAppointmentCubit>().selectSlot(
                                slot.id,
                              );
                            },
                          ),
                          SizedBox(height: 120.h),
                        ],
                      ),
                    ),
            ),
            bottomNavigationBar: isLoading
                ? const BookingBottomBarShimmer()
                : BookingBottomBar(
                    doctorId: widget.args.doctorId,
                    selectedDate: selectedDate,
                    selectedTime: selectedSlotTime,
                  ),
          );
        },
      ),
    );
  }
}
