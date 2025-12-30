import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication', style: TextStyle(fontSize: 18.sp)),
      ),
      body: Center(
        child: Text(
          'Authentication Feature',
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
    );
  }
}
