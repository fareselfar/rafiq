import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorStatusBadge extends StatelessWidget {
  final bool isAvailable;

  const DoctorStatusBadge({super.key, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFFE2F9F0) : const Color(0xFFFFF1E6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        isAvailable ? "متوفر الآن" : "متاح غداً",
        style: TextStyle(
          color:
              isAvailable ? const Color(0xFF1ABC9C) : const Color(0xFFE67E22),
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
