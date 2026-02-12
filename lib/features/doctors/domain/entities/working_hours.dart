import 'package:equatable/equatable.dart';

class WorkingHours extends Equatable {
  final String day;
  final String time; // مثال: "10:00 ص - 4:00 م"
  final bool isClosed; // عشان حالات "مغلق"

  const WorkingHours({required this.day, required this.time, this.isClosed = false});

  @override
  List<Object?> get props => [day, time, isClosed];
}