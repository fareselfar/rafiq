class WeeklyScheduleModel {
  final String dayName;
  final String timeRange;
  final bool isClosed;

  const WeeklyScheduleModel({
    required this.dayName,
    required this.timeRange,
    required this.isClosed,
  });

  factory WeeklyScheduleModel.fromJson(Map<String, dynamic> json) {
    return WeeklyScheduleModel(
      dayName: json['dayName'] ?? '',
      timeRange: json['timeRange'] ?? '',
      isClosed: json['isClosed'] ?? false,
    );
  }
}

class DoctorProfileModel {
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
  final List<WeeklyScheduleModel> weeklySchedule;

  const DoctorProfileModel({
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

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorProfileModel(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? '',
      specialization: json['specialization'] ?? '',
      imagePath: json['imagePath'],
      rate: (json['rate'] ?? 0.0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      bio: json['bio'] ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      yearsOfExperience: json['yearsOfExperience'] ?? 0,
      patientsCount: json['patientsCount'] ?? 0,
      waitingTime: json['waitingTime'] ?? 0,
      address: json['address'],
      weeklySchedule: (json['weeklySchedule'] as List<dynamic>? ?? [])
          .map((e) => WeeklyScheduleModel.fromJson(e))
          .toList(),
    );
  }
}