import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/booking_details/booking_details_shimmer.dart';

class BookingAppointmentShimmerBody extends StatelessWidget {
  const BookingAppointmentShimmerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeightSpace(10),
          // 1. Shimmer الـ DoctorBriefInfo بالملي
          Center(
            child: Column(
              children: [
                SkeletonWidget(
                  width: 110.r,
                  height: 110.r,
                  borderRadius: BorderRadius.circular(55.r),
                ),
                const HeightSpace(8),
                SkeletonWidget(width: 150.w, height: 18.h),
                const HeightSpace(5),
                SkeletonWidget(width: 100.w, height: 14.h),
                const HeightSpace(8),
                SkeletonWidget(
                  width: 130.w,
                  height: 24.h,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                const HeightSpace(8),
                SkeletonWidget(width: 180.w, height: 14.h),
                const HeightSpace(8),
                SkeletonWidget(width: 120.w, height: 14.h),
              ],
            ),
          ),
          const HeightSpace(20),

          // 2. Shimmer الـ Selection Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonWidget(width: 80.w, height: 18.h),
              SkeletonWidget(width: 90.w, height: 16.h),
            ],
          ),
          const HeightSpace(10),

          // 3. Shimmer الـ BookingDateSelector الافقي (7 أيام)
          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemBuilder: (_, __) => Container(
                width: 65.w,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SkeletonWidget(width: 35.w, height: 12.h),
                    const HeightSpace(4),
                    SkeletonWidget(width: 25.w, height: 16.h),
                  ],
                ),
              ),
            ),
          ),
          const HeightSpace(12),

          // 4. Shimmer الـ BookingCalendarPicker
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonWidget(width: 100.w, height: 16.h),
                    Row(
                      children: [
                        SkeletonWidget(width: 24.w, height: 24.h),
                        SizedBox(width: 8.w),
                        SkeletonWidget(width: 24.w, height: 24.h),
                      ],
                    ),
                  ],
                ),
                const HeightSpace(12),
                SkeletonWidget(width: double.infinity, height: 40.h),
              ],
            ),
          ),
          const HeightSpace(24),

          // 5. Shimmer المواعيد المتاحة (Grid مكون من 6 خانات)
          SkeletonWidget(width: 110.w, height: 18.h),
          const HeightSpace(12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: 6,
            itemBuilder: (_, __) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Center(
                child: SkeletonWidget(width: 50.w, height: 14.h),
              ),
            ),
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }
}

/// هيكل تحميل البار السفلي للتأكيد (Bottom Bar Shimmer)
class BookingBottomBarShimmer extends StatelessWidget {
  const BookingBottomBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.h,
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      color: Colors.white,
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
