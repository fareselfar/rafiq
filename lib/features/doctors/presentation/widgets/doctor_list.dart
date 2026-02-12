import 'package:flutter/material.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/presentation/widgets/custom_doctor_container.dart';

class DoctorsList extends StatelessWidget {

  final List<DoctorsEntity> doctors;

  const DoctorsList({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (_, index) {
        return CustomDoctorContainer(
          doctor: doctors[index],
        );
      },
    );
  }
}
