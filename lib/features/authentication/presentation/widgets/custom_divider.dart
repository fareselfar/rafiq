import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  final String title;
  const CustomDivider({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 131.5, child: Divider(color: Color(0xff5B5B5B))),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Color(0xff5B5B5B)),
          ),
          SizedBox(width: 131.5, child: Divider(color: Color(0xff5B5B5B))),
        ],
      ),
    );
  }
}
