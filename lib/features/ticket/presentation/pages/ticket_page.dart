import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketTab extends StatelessWidget {
  const TicketTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket', style: TextStyle(fontSize: 18.sp)),
      ),
      body: Center(
        child: Text('Ticket Feature', style: TextStyle(fontSize: 24.sp)),
      ),
    );
  }
}
