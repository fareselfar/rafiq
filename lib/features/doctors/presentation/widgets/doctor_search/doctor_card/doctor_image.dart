import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorImage extends StatelessWidget {
  final String? imageUrl;

  const DoctorImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32.r,
      backgroundColor: const Color(0xFFE3F2FD),
      backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
          ? NetworkImage(imageUrl!)
          : null,
      child: (imageUrl == null || imageUrl!.isEmpty)
          ? Icon(Icons.person, size: 32.r, color: const Color(0xFF90CAF9))
          : null,
    );
  }
}
