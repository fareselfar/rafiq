import 'package:flutter/material.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/data/models/doctor_model.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctor_card/doctor_image.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctor_card/doctor_info.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctor_card/doctor_rating.dart';

class DoctorHeader extends StatelessWidget {
  final DoctorsModel doctor;
  const DoctorHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DoctorImage(imageUrl: doctor.imageUrl),
        const WidthSpace(16),
        DoctorInfo(doctor: doctor),
        DoctorRating(rating: doctor.rating),
      ],
    );
  }
}