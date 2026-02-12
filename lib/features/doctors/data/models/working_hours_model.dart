import 'package:rafiq/features/doctors/domain/entities/working_hours.dart';

class WorkingHoursModel extends WorkingHours {
  const WorkingHoursModel({required super.day, required super.time, super.isClosed});

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) {
    return WorkingHoursModel(
      day: json['day'] ?? '',
      time: json['time'] ?? '',
      isClosed: json['is_closed'] ?? false,
    );
  }
}