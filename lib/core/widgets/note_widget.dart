import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/card_widget.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      cardColor: AppColors.note,
      borderColor: AppColors.info,
      borderWidth: 2,
      widget: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 19),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.info, size: 40.sp),
            WidthSpace(20),
            Text(
              "8احرف على الاقل\n حرف كبير واحد على الاقل (A-Z)\n رقم واحد على الاقل (0-9)",
              style: AppTypography.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
