import 'package:equatable/equatable.dart';

class WorkingHours extends Equatable {
  final String day;
  final String time;
  final bool isClosed;

  const WorkingHours({required this.day, required this.time, this.isClosed = false});

  @override
  List<Object?> get props => [day, time, isClosed];
}