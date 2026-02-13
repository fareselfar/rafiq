import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/date_formatter.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import '../../domain/entities/message_entity.dart';

class ChatBubble extends StatelessWidget {
  final MessageEntity message;
  final Color? senderColor;
  final Color? receiverColor;

  const ChatBubble({
    super.key,
    required this.message,
    this.senderColor,
    this.receiverColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUserMessage = message.sender == 'user';

    final Color bubbleColor = isUserMessage
        ? (senderColor ?? AppColors.primary)
        : (receiverColor ?? AppColors.surface);

    final Color textColor = isUserMessage ? Colors.white : Colors.black87;

    final BorderRadiusGeometry borderRadius = BorderRadius.only(
      topLeft: Radius.circular(12.r),
      topRight: Radius.circular(12.r),
      bottomLeft: isUserMessage ? Radius.circular(24.r) : Radius.circular(0.r),
      bottomRight: isUserMessage ? Radius.circular(0.r) : Radius.circular(24.r),
    );

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: isUserMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: AppTypography.bubbleMessage.copyWith(color: textColor),
                ),
                HeightSpace(4),
                Text(
                  DateFormatter.formatTimeOnly(message.time),
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          if (!isUserMessage) ...[
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                'assets/images/svg/baby.svg',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
            WidthSpace(4),
          ],
        ],
      ),
    );
  }
}
