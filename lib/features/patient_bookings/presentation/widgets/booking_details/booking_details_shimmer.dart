import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

/// 1. الويدجت الأساسية العامة للـ Shimmer (مفتوحة للاستخدام في أي مكان بالتطبيق)
class SkeletonWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const SkeletonWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
        ),
      ),
    );
  }
}

/// 2. هيكل تحميل محتوى الصفحة بالكامل (Body Shimmer)
class BookingDetailsShimmerBody extends StatelessWidget {
  const BookingDetailsShimmerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer كارت الدكتور
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonWidget(
                      width: 70.r,
                      height: 70.r,
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                    const WidthSpace(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonWidget(width: 120.w, height: 16.h),
                          const HeightSpace(8),
                          SkeletonWidget(width: 80.w, height: 12.h),
                        ],
                      ),
                    ),
                    SkeletonWidget(
                      width: 60.w,
                      height: 22.h,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ],
                ),
                const HeightSpace(16),
                SkeletonWidget(width: 140.w, height: 14.h),
              ],
            ),
          ),
          const HeightSpace(20),

          // Shimmer حالة الحجز
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonWidget(width: 90.w, height: 18.h),
              SkeletonWidget(
                width: 80.w,
                height: 24.h,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ],
          ),
          const HeightSpace(25),

          // Shimmer عنوان "تفاصيل الحجز"
          Align(
            alignment: Alignment.centerRight,
            child: SkeletonWidget(width: 100.w, height: 18.h),
          ),
          const HeightSpace(12),

          // Shimmer الـ GridView
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 14.h,
            crossAxisSpacing: 14.w,
            childAspectRatio: 1.7,
            children: List.generate(
              4,
              (index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SkeletonWidget(
                          width: 16.w,
                          height: 16.h,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        const WidthSpace(6),
                        SkeletonWidget(width: 40.w, height: 12.h),
                      ],
                    ),
                    SkeletonWidget(width: 90.w, height: 16.h),
                  ],
                ),
              ),
            ),
          ),
          const HeightSpace(20),

          // Shimmer ملخص الفاتورة
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonWidget(width: 110.w, height: 18.h),
                const HeightSpace(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonWidget(width: 80.w, height: 14.h),
                    SkeletonWidget(width: 50.w, height: 14.h),
                  ],
                ),
                const HeightSpace(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonWidget(width: 40.w, height: 14.h),
                    SkeletonWidget(width: 50.w, height: 14.h),
                  ],
                ),
                const HeightSpace(14),
                const Divider(color: Color(0xFFE8F1FF), thickness: 1),
                const HeightSpace(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SkeletonWidget(width: 90.w, height: 18.h),
                    SkeletonWidget(width: 60.w, height: 18.h),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 3. هيكل تحميل أزرار التحكم بالأسفل (Actions Shimmer)
class BookingActionsShimmer extends StatelessWidget {
  const BookingActionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SkeletonWidget(
            width: double.infinity,
            height: 48.h,
            borderRadius: BorderRadius.circular(12.r),
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
