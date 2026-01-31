import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class DoctorTab extends StatelessWidget {
  const DoctorTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('البحث'),
        backgroundColor: AppColors.surface,
        leadingWidth: 30.w,
        iconTheme: IconThemeData(size: 33),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              CustomSearchField(
                hint: 'البحث',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.filter_list),
              ),
              HeightSpace(10),
              Image.asset(AssetsManger.search, height: 240.h),
              HeightSpace(8),
              Text(
                'ابدأ البحث عن طبيب أو تخصص',
                style: GoogleFonts.cairo(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.info,
                ),
              ),
              HeightSpace(8),
              Text(
                'اكتب اسم الطبيب او التخصص للعثور على',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.selectedText,
                ),
              ),
              Text(
                'ما يناسبك بسرعة وسهولة',
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.selectedText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
