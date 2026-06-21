import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/domain/entities/patient_booking_entities.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';

class BookingDetailsActions extends StatelessWidget {
  final AppointmentDetailsEntity details;

  const BookingDetailsActions({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bool isUpcoming = details.isUpcoming;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isUpcoming) ...[
            CustomButton(
              text: "إعادة جدولة الحجز",
              onPressed: () {
                context.navigateTo(
                  Routes.editAppointmentScreen,
                  arguments: details,
                );
              },
              width: size.width,
            ),
            const HeightSpace(12),
            CustomButton(
              text: "إلغاء الحجز",
              onPressed: () {
                // إطلاق الـ usecase الفعلي للإلغاء من الـ Cubit
                context.read<AppointmentsCubit>().cancelAppointment(details.id);
              },
              backgroundColor: AppColors.error,
              width: size.width,
            ),
          ] else ...[
            CustomButton(
              text: "العودة إلى الرئيسية",
              onPressed: () => context.navigateAndRemoveUntil("/home"),
              width: size.width,
            ),
            const HeightSpace(12),
            CustomButton(
              text: "الانتقال الى حجوزاتي",
              onPressed: () => context.navigateAndRemoveUntil("/patienthome", arguments: 3),
              type: ButtonType.outlined,
              width: size.width,
            ),
          ],
        ],
      ),
    );
  }
}