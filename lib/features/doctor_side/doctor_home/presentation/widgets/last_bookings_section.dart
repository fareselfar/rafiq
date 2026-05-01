// lib/features/doctor_side/doctor_home/presentation/widgets/last_bookings_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_last_booking_entity.dart';
import '../../domain/entities/doctor_home_entity.dart';
import 'doctor_section_header.dart';

class LastBookingsSection extends StatelessWidget {
  final List<DoctorLastBookingEntity> bookings;
  final VoidCallback? onViewAll;

  const LastBookingsSection({
    super.key,
    required this.bookings,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // RTL: start = RIGHT ✓
      children: [
        DoctorSectionHeader(
          title: 'اخر الحجوزات',
          trailing: ViewAllLink(onTap: onViewAll),
        ),
        const HeightSpace(12),
        bookings.isEmpty
            ? const _EmptyBookingsWidget()
            : _BookingsList(bookings: bookings),
      ],
    );
  }
}

class _BookingsList extends StatelessWidget {
  final List<DoctorLastBookingEntity> bookings;

  const _BookingsList({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (_, i) => _BookingCard(booking: bookings[i]),
    );
  }
}

/// Booking card — green right border, مكتمل chip on left
class _BookingCard extends StatelessWidget {
  final DoctorLastBookingEntity booking;

  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          right: BorderSide(color: AppColors.success, width: 4.w),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        // No textDirection override — RTL app: [0]=RIGHT=Avatar, [2]=LEFT=Chip ✓
        children: [
          _BookingAvatar(name: booking.patientName),
          const WidthSpace(12),
          Expanded(child: _BookingInfo(booking: booking)),
          const _CompletedChip(),
        ],
      ),
    );
  }
}

class _BookingAvatar extends StatelessWidget {
  final String name;

  const _BookingAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: const BoxDecoration(
        color: Color(0xFFDBEAFE),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name.characters.first : '؟',
          style: AppTypography.bodymid.copyWith(
            color: AppColors.primary,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

class _BookingInfo extends StatelessWidget {
  final DoctorLastBookingEntity booking;

  const _BookingInfo({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // RTL: start = RIGHT ✓
      children: [
        Text(
          booking.patientName,
          style: AppTypography.bodymid.copyWith(
            color: AppColors.selectedText,
            fontSize: 14.sp,
          ),
        ),
        const HeightSpace(3),
        Text(
          '${booking.date} • ${booking.time}',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _CompletedChip extends StatelessWidget {
  const _CompletedChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.greenWhite,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'مكتمل',
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.success,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyBookingsWidget extends StatelessWidget {
  const _EmptyBookingsWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(
          'لا توجد حجوزات سابقة',
          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}