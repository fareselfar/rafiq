import 'package:flutter/material.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctor_card/doctor_image.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctor_card/doctor_info.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctor_card/doctor_rating.dart';

class DoctorHeader extends StatelessWidget {
  final DoctorEntity doctor;
  const DoctorHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DoctorImage(imageUrl: doctor.imagePath),
        const WidthSpace(16),
        DoctorInfo(doctor: doctor),
        DoctorRating(rating: doctor.rate),
      ],
    );
  }
}
