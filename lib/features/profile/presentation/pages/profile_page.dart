import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontSize: 18.sp)),
      ),
      body: Center(
        child: Text('Profile Feature', style: TextStyle(fontSize: 24.sp)),
      ),
    );
  }
}
