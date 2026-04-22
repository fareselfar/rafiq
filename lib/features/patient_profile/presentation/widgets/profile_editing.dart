import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class ProfileEditing extends StatelessWidget {
  const ProfileEditing({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
  });
  final String icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          WidthSpace(4),
          Text(label, style: AppTypography.profileServiceDetailsStyle),
          Spacer(),
          Icon(Icons.arrow_back_ios_new_outlined, color: AppColors.hintStyle),
        ],
      ),
    );
  }
}
