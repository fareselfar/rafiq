import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorImage extends StatelessWidget {
  final String? imageUrl;

  const DoctorImage({super.key, this.imageUrl});

  bool get _hasValidImage {
    if (imageUrl == null || imageUrl!.isEmpty) return false;
    final uri = Uri.tryParse(imageUrl!);
    if (uri == null) return false;
    return uri.path.isNotEmpty && uri.path != '/';
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32.r,
      backgroundColor: const Color(0xFFE3F2FD),
      backgroundImage: _hasValidImage ? NetworkImage(imageUrl!) : null,
      onBackgroundImageError: _hasValidImage ? (_, _) {} : null,
      child: !_hasValidImage
          ? Icon(Icons.person, size: 32.r, color: const Color(0xFF90CAF9))
          : null,
    );
  }
}