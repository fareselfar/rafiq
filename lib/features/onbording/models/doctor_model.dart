import 'package:flutter/foundation.dart';

class DoctorModel {
  final String image;
  final String doctorName;
  final String doctorSpecialization;
  final String doctorRate;
  final String doctorLocation;
  final String doctorPrice;
  final VoidCallback onTap;
  DoctorModel({
    required this.image,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorRate,
    required this.doctorLocation,
    required this.doctorPrice,
    required this.onTap,
  });
}
