import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class BookingDetailsGrid extends StatelessWidget {
  final DateTime date;
  final String time;

  const BookingDetailsGrid({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 14.h,
      crossAxisSpacing: 14.w,
      childAspectRatio: 1.7,
      children: [
        _buildDetailItem("اليوم", "الاثنين", Icons.calendar_month),

        _buildDetailItem(
          "التاريخ",
          "${date.day} يناير ${date.year}",
          Icons.date_range,
        ),
        _buildDetailItem("الوقت", time, Icons.access_time),

        _buildDetailItem(
          "العنوان",
          "طنطا شارع البحر",
          Icons.location_on_outlined,
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border(
          left: BorderSide(color: AppColors.primary, width: 1.w),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(.25),
            blurRadius: 10.r,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, size: 16.sp, color: AppColors.primary),
              const WidthSpace(6),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
