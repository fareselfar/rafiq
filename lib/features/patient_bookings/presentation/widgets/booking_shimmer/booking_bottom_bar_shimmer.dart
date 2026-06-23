// lib/features/patient_bookings/presentation/widgets/booking_shimmer/booking_bottom_bar_shimmer.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_details/booking_details_shimmer.dart';

class BookingBottomBarShimmer extends StatelessWidget {
  const BookingBottomBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 12.h, left: 20.w, right: 20.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonWidget(width: 90.w, height: 16.h),
              SkeletonWidget(width: 120.w, height: 14.h),
            ],
          ),
          const HeightSpace(12),
          SkeletonWidget(
            width: double.infinity,
            height: 48.h,
            borderRadius: BorderRadius.circular(12.r),
          ),
        ],
      ),
    );
  }
}