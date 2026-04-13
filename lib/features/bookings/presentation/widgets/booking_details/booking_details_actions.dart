import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/bookings/domain/entities/bookings_entity.dart';

class BookingDetailsActions extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsActions({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bool isUpcoming = booking.status == BookingStatus.upcoming;

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
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
                    arguments: booking,
                  );
                },
                width: size.width,
              ),
              const HeightSpace(12),
              CustomButton(
                text: "إلغاء الحجز",
                onPressed: () {},
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
                onPressed: () =>
                    context.navigateAndRemoveUntil("/home", arguments: 3),
                type: ButtonType.outlined,
                width: size.width,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
