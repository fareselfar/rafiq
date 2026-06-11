import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/features/patient_side/patient_bookings/domain/entities/bookings_entity.dart';
import '../../../../../../core/widgets/cancel_booking_dialog.dart';

class BookingActionButtons extends StatelessWidget {
  final BookingEntity booking;

  const BookingActionButtons({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        SizedBox(
          width: size.width,
          child: CustomButton(
            text: "عرض التفاصيل",
            onPressed: () {
              context.navigateTo("/bookingDetailsScreen", arguments: booking);
            },
            height: 40.h,
          ),
        ),
        if (booking.status == BookingStatus.upcoming) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: CustomButton(
                    text: "تعديل",
                    onPressed: () {
                      context.navigateTo(
                        Routes.editAppointmentScreen,
                        arguments: booking,
                      );
                    },
                    type: ButtonType.outlined,
                    height: 40.h,
                  ),
                ),
              ),
              WidthSpace(8),
              Expanded(
                child: SizedBox(
                  child: CustomButton(
                    text: "إلغاء",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const CancelBookingDialog(),
                      );
                    },
                    height: 40.h,
                    backgroundColor: AppColors.darkRed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
