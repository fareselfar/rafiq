class DoctorEntity {
  final int id;
  final String fullName;
  final String specialization;
  final String? imagePath;
  final double rate;
  final double? price;
  final String address;
  final bool isAvailableToday;

  const DoctorEntity({
    required this.id,
    required this.fullName,
    required this.specialization,
    this.imagePath,
    required this.rate,
    this.price,
    required this.address,
    required this.isAvailableToday,
  });
}
class WeeklyScheduleEntity {
  final String dayName;
  final String timeRange;
  final bool isClosed;

  const WeeklyScheduleEntity({
    required this.dayName,
    required this.timeRange,
    required this.isClosed,
  });
}

class DoctorProfileEntity {
  final int id;
  final String fullName;
  final String specialization;
  final String? imagePath;
  final double rate;
  final int reviewsCount;
  final String bio;
  final double? price;
  final int yearsOfExperience;
  final int patientsCount;
  final int waitingTime;
  final String? address;
  final List<WeeklyScheduleEntity> weeklySchedule;

  const DoctorProfileEntity({
    required this.id,
    required this.fullName,
    required this.specialization,
    this.imagePath,
    required this.rate,
    required this.reviewsCount,
    required this.bio,
    this.price,
    required this.yearsOfExperience,
    required this.patientsCount,
    required this.waitingTime,
    this.address,
    required this.weeklySchedule,
  });
}