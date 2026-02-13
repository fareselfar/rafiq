import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorImage extends StatelessWidget {
  final String imageUrl;

  const DoctorImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.r,
      height: 65.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/doctor_image_profile.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
