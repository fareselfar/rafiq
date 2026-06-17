class DoctorProfileEntity {
  final String fullName;
  final int age;
  final String gender;
  final String? imagePath;
  final int appointmentsCount;
  final String? email;
  const DoctorProfileEntity({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.imagePath,
    required this.appointmentsCount,
    this.email,
  });
}
