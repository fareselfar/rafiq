import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/details_card.dart';
import 'package:rafiq/features/profile/presentation/widgets/options_card.dart';
import 'package:rafiq/features/profile/presentation/widgets/services_card.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ملفي الشخصي', style: AppTypography.appBarTitelStyle),
        actions: [
          Padding(
            padding: REdgeInsets.only(left: 16),
            child: InkWell(child: SvgPicture.asset(SvgManger.edit)),
          ),
        ],
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardWidget(
                width: double.infinity,
                verticalPadding: 16.r,
                widget: Column(
                  children: [
                    Image.asset(IconManger.profileImg),
                    HeightSpace(8),
                    Text("محمد علي", style: AppTypography.profileNameStyle),
                    HeightSpace(8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Padding(
                        padding: REdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        child: Text(
                          "مستخدم",
                          style: AppTypography.profileRoleStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              HeightSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DetailsCard(title: 'العمر', value: '21'),
                  WidthSpace(16),
                  DetailsCard(title: 'الجنس', value: 'ذكر'),
                  WidthSpace(16),
                  DetailsCard(title: 'الحجوزات', value: "12"),
                ],
              ),
              HeightSpace(20),
              Text(
                "الخدمات السريعة",
                style: AppTypography.profileServicesStyle,
                textAlign: TextAlign.start,
              ),
              HeightSpace(8),
              Row(
                children: [
                  ServicesCard(
                    onTap: () {},
                    icon: SvgManger.calendar,
                    serviceName: "حجوزاتي",
                    servicesDetails: "مواعيدك القادمة",
                    borderColor: AppColors.primary,
                  ),
                  WidthSpace(20),
                  ServicesCard(
                    onTap: () {},
                    icon: SvgManger.files,
                    textColor: AppColors.purple,
                    serviceName: "ملفاتي الطبية",
                    servicesDetails: "تقارير وتحاليل",
                    borderColor: AppColors.purple,
                  ),
                ],
              ),
              HeightSpace(16),
              Row(
                children: [
                  ServicesCard(
                    onTap: () {},
                    icon: SvgManger.upload,
                    serviceName: "حجوزاتي",
                    servicesDetails: "مواعيدك القادمة",
                    borderColor: AppColors.primary,
                  ),
                  WidthSpace(20),
                  ServicesCard(
                    onTap: () {},

                    icon: SvgManger.articles,
                    serviceName: "ملفاتي الطبية",
                    servicesDetails: "تقارير وتحاليل",
                    borderColor: AppColors.primary,
                  ),
                ],
              ),
              HeightSpace(20),
              OptionsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
