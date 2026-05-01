// lib/features/doctor_side/doctor_home/presentation/pages/doctor_home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/datasources/doctor_home_dummy_data.dart';
import 'package:rafiq/features/doctor_side/doctor_home/data/datasources/doctor_home_remote_datasource_mock.dart';
import 'package:rafiq/features/doctor_side/doctor_home/presentation/bloc/doctor_home_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/repositories/doctor_home_repository_impl.dart';
import '../../domain/entities/doctor_home_entity.dart';
import '../../domain/usecases/get_doctor_home_data_usecase.dart';
import '../widgets/articles_section.dart';
import '../widgets/doctor_greeting_section.dart';
import '../widgets/doctor_home_top_bar.dart';
import '../widgets/doctor_stats_grid.dart';
import '../widgets/last_bookings_section.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/today_schedule_section.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final datasource = DoctorHomeRemoteDataSourceMock();
        final repository = DoctorHomeRepositoryImpl(
          remoteDataSource: datasource, networkInfo: Object(),
        );
        final usecase = GetDoctorHomeDataUsecase(repository);
        return DoctorHomeCubit(getDoctorHomeData: usecase)..loadData();
      },
      child: const _DoctorHomeView(),
    );
  }
}

class _DoctorHomeView extends StatelessWidget {
  const _DoctorHomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SafeArea(
        child: BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
          builder: (context, state) {
            if (state is DoctorHomeLoading || state is DoctorHomeInitial) {
              return const _HomeLoadingView();
            }
            if (state is DoctorHomeError) {
              return _HomeErrorView(
                message: state.message,
                onRetry: () => context.read<DoctorHomeCubit>().loadData(),
              );
            }
            if (state is DoctorHomeLoaded) {
              return _HomeContentView(data: state.data);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

// ─── Content ──────────────────────────────────────────────────────────────────

class _HomeContentView extends StatelessWidget {
  final DoctorHomeEntity data;

  const _HomeContentView({required this.data});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<DoctorHomeCubit>().loadData(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeightSpace(16),

            // ── Top bar: Bell | Name + Avatar ──
            DoctorHomeTopBar(doctorName: data.doctorName),

            HeightSpace(16),

            // ── Greeting: أهلاً بك دكتور... + count ──
            DoctorGreetingSection(
              doctorName: data.doctorName,
              todayAppointmentsCount: data.todayAppointmentsCount,
            ),

            HeightSpace(20),

            // ── 2×2 Stats grid ──
            DoctorStatsGrid(stats: data.stats),

            HeightSpace(24),

            // ── Today's schedule ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TodayScheduleSection(appointments: data.todaySchedule),
            ),

            HeightSpace(24),

            // ── Articles ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ArticlesSection(articles: data.articles),
            ),

            HeightSpace(24),

            // ── Last bookings ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: LastBookingsSection(bookings: data.lastBookings),
            ),

            HeightSpace(24),

            // ── Quick actions ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const QuickActionsSection(),
            ),

            HeightSpace(32),
          ],
        ),
      ),
    );
  }
}

// ─── Loading ──────────────────────────────────────────────────────────────────

class _HomeLoadingView extends StatelessWidget {
  const _HomeLoadingView();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: _HomeContentView(
        data: DoctorHomeDummyData.loading(),
      ),
    );
  }
}

// ─── Error ────────────────────────────────────────────────────────────────────

class _HomeErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _HomeErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 56.sp,
            ),
            const HeightSpace(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const HeightSpace(20),
            _RetryButton(onRetry: onRetry),
          ],
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  final VoidCallback onRetry;

  const _RetryButton({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          'إعادة المحاولة',
          style: AppTypography.bodymid.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
