import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorArticlesPage extends StatelessWidget {
  const DoctorArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DoctorArticles', style: TextStyle(fontSize: 18.sp)),
      ),
      body: Center(
        child: Text(
          'DoctorArticles Feature',
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
    );
  }
}
