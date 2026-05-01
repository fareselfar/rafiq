import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorAppointmentsPage extends StatelessWidget {
  const DoctorAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DoctorAppointments', style: TextStyle(fontSize: 18.sp)),
      ),
      body: Center(
        child: Text(
          'DoctorAppointments Feature',
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
    );
  }
}
