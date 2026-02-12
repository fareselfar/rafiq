import 'package:flutter/material.dart';
import 'package:rafiq/core/enums/doctor_availability.dart';
import 'package:rafiq/core/theme/app_colors.dart';

extension DoctorAvailabilityX on DoctorAvailability {
  String get text {
    switch (this) {
      case DoctorAvailability.availableNow:
        return 'متوفر الآن';
      case DoctorAvailability.availableTomorrow:
        return 'متوفر غداً';
      case DoctorAvailability.unavailable:
        return 'غير متوفر';
    }
  }

  Color get color {
    switch (this) {
      case DoctorAvailability.availableNow:
        return AppColors.selectedDoctor;
      case DoctorAvailability.availableTomorrow:
        return AppColors.darkRed;
      case DoctorAvailability.unavailable:
        return AppColors.red;
    }
  }
}
