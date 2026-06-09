// lib/features/doctor_side/doctor_home/presentation/widgets/doctor_stats_grid.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_home/domain/entities/doctor_home_stats_entity.dart';

/// 2×2 Stats grid.
/// RTL app: Row children render right-to-left automatically.
/// No textDirection overrides needed anywhere.
class DoctorStatsGrid extends StatelessWidget {
  final DoctorHomeStatsEntity stats;

  const DoctorStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DoctorStatCard(
                  label: 'حجوزات اليوم',
                  labelColor: AppColors.selectedDoctor,
                  value: '${stats.todayBookings}',
                ),
              ),
              WidthSpace(14),
              Expanded(
                child: DoctorStatCard(
                  label: 'مواعيد الاسبوع',
                  labelColor: AppColors.purple,
                  value: '${stats.weeklyAppointments}',
                ),
              ),
            ],
          ),
          HeightSpace(14),
          Row(
            children: [
              Expanded(
                child: DoctorStatCard(
                  label: 'تقييمك',
                  labelColor: AppColors.warning,
                  value: '${stats.rating}',
                  valueLeadingIcon: const _StarIcon(),
                ),
              ),
              WidthSpace(14),
              Expanded(
                child: DoctorStatCard(
                  label: 'ارباح الشهر',
                  labelColor: AppColors.success,
                  value: _formatEarnings(stats.monthlyEarnings),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatEarnings(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)},000 جنيه';
    }
    return '${value.toStringAsFixed(0)} جنيه';
  }
}

/// Single stat card — white, rounded-16, shadow
class DoctorStatCard extends StatelessWidget {
  final String label;
  final Color labelColor;
  final String value;
  final Widget? valueLeadingIcon; // shown before value (e.g. star ★)

  const DoctorStatCard({
    super.key,
    required this.label,
    required this.labelColor,
    required this.value,
    this.valueLeadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return _StatCardShell(
      child: Column(
        // CrossAxisAlignment.start = RIGHT in RTL app ✓
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatCardLabel(label: label, color: labelColor),
          const HeightSpace(8),
          _StatCardValue(value: value, leadingIcon: valueLeadingIcon),
        ],
      ),
    );
  }
}

/// White card container with shadow
class _StatCardShell extends StatelessWidget {
  final Widget child;

  const _StatCardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Colored label — no textDirection override
class _StatCardLabel extends StatelessWidget {
  final String label;
  final Color color;

  const _StatCardLabel({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.bodySmall.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 13.sp,
      ),
    );
  }
}

/// Value row: [★ icon?] [value text]
/// Row children in RTL render right-to-left automatically.
class _StatCardValue extends StatelessWidget {
  final String value;
  final Widget? leadingIcon;

  const _StatCardValue({required this.value, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment.start = RIGHT in RTL ✓
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leadingIcon != null) ...[leadingIcon!, const WidthSpace(4)],
        Text(
          value,
          style: AppTypography.profileServiceDetailsStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.selectedText,
          ),
        ),
      ],
    );
  }
}

/// Orange star ★
class _StarIcon extends StatelessWidget {
  const _StarIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.star_rounded, color: AppColors.warning, size: 18.sp);
  }
}
