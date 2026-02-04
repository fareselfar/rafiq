import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class RobotImageAndWelcomeText extends StatelessWidget {
  const RobotImageAndWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeightSpace(20),
          Image.asset(AssetsManger.rafiqChatBot, height: 287.h, width: 300.w),
          const HeightSpace(8),
          Text(
            "أنا رفيق مساعدك الصحي",
            style: AppTypography.subTitelStyle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const HeightSpace(10),
          Text(
            "اسألني عن أعراضك، صحتك أو أي\nاستفسار طبي",
            style: AppTypography.bodymid.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
