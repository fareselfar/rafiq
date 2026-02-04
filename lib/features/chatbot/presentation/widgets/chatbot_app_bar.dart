import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';

class ChatBotAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  final String title;
  final VoidCallback? onBackPressed;

  const ChatBotAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 10,
      centerTitle: true,

      title: Text(
        title,
        style: AppTypography.subTitelStyle.copyWith(
          color: AppColors.appBar,
        ),
      ),

      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed,
      ),
    );
  }
}
