import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatbotTab extends StatelessWidget {
  const ChatbotTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot', style: TextStyle(fontSize: 18.sp)),
      ),
      body: Center(
        child: Text('Chatbot Feature', style: TextStyle(fontSize: 24.sp)),
      ),
    );
  }
}
