import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'doctor_location.dart';
import 'doctor_status_badge.dart';

class DoctorAvailabilitySection extends StatelessWidget {
  final String address;
  final bool isAvailable;

  const DoctorAvailabilitySection({
    super.key,
    required this.address,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: DoctorLocation(address: address)),
        SizedBox(width: 10.w),
        DoctorStatusBadge(isAvailable: isAvailable),
      ],
    );
  }
}
