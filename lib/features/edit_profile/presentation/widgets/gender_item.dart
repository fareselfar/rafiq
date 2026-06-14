import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderItem extends StatelessWidget {
  final String title;
  final String value;
  final String selectedGender;
  final IconData icon;
  final VoidCallback onTap;

  const GenderItem({
    super.key,
    required this.title,
    required this.value,
    required this.selectedGender,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedGender == value;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: isSelected ? Colors.blue : Colors.grey),
            ),
            SizedBox(width: 8.w),
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
          ],
        ),
      ),
    );
  }
}
