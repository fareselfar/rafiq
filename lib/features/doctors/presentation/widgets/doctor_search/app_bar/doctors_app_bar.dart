import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/features/doctors/presentation/bloc/doctors_cubit.dart';
import 'filter_chips_section.dart';

class DoctorsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onSearch;

  const DoctorsAppBar({super.key, this.onSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_forward, color: AppColors.primary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('الأطباء', style: AppTypography.appBarTitelStyle),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(110.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const FilterChipsSection(),
              SizedBox(height: 12.h),
              CustomSearchField(
                hint: 'البحث',
                onChanged: (value) {
                  // ✅ كل ما يكتب يعمل search
                  context.read<DoctorsCubit>().loadDoctors(search: value);
                },
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(160.h);
}