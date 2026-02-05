import 'package:flutter/foundation.dart';

class SpecializationModel {
  final String image;
  final String name;
  final String numberOfDoctors;
  VoidCallback onTap;
  SpecializationModel({
    required this.image,
    required this.name,
    required this.numberOfDoctors,
    required this.onTap,
  });
}
