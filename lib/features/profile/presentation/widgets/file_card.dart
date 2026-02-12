import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/data/models/file_model.dart';
import 'package:rafiq/features/profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/small_card.dart';

class FileCard extends StatelessWidget {
  const FileCard({super.key, required this.fileModel});
  final FileModel fileModel;
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      verticalPadding: 16,
      horizontalPadding: 10,
      widget: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(fileModel.image, width: 40.w),
              WidthSpace(8),
              Column(
                children: [
                  Text(fileModel.title, style: AppTypography.inputLabel),
                  HeightSpace(4),
                  Text(fileModel.date, style: AppTypography.inputLabel),
                ],
              ),
              WidthSpace(35),
              SmallCard(
                title: " عرض التفاصيل",
                hightPadding: 6,
                widthPadding: 20,
                onTap: () {},
              ),
            ],
          ),
          HeightSpace(16),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              backgroundColor: AppColors.darkRed,
              text: 'تحميل',
              onPressed: () {},
              height: 45.h,
            ),
          ),
        ],
      ),
    );
  }
}
