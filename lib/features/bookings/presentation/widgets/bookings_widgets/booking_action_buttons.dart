import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/bookings/data/models/bookings_model.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import '../../../../../core/widgets/cancel_booking_dialog.dart';

class BookingActionButtons extends StatelessWidget {
  final BookingModel booking;

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
            onPressed: () {},
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
                    onPressed: () {},
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
