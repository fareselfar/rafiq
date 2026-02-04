import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/chat_Header.dart';
import 'package:rafiq/features/chatbot/presentation/widgets/privacy_note_widget.dart';

class BuildWelcomeBody extends StatelessWidget {
  const BuildWelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: const [
          RobotImageAndWelcomeText(),
          HeightSpace(20),
          PrivacyNote(),
        ],
      ),
    );
  }
}
