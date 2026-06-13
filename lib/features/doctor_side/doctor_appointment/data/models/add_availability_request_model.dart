// lib/features/doctor_side/doctor_appointments/data/models/add_availability_request_model.dart

import 'package:flutter/material.dart';

class AddAvailabilityRequestModel {
  final String fromTime;
  final String toTime;
  final String specificDate;

  const AddAvailabilityRequestModel({
    required this.fromTime,
    required this.toTime,
    required this.specificDate,
  });

  Map<String, dynamic> toJson() => {
        'fromTime': fromTime,
        'toTime': toTime,
        'specificDate': specificDate,
      };

  /// من DateTime مباشرة
  factory AddAvailabilityRequestModel.fromDateTime({
    required DateTime date,
    required TimeOfDay from,
    required TimeOfDay to,
  }) {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final fromStr =
        '${from.hour.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')}:00';
    final toStr =
        '${to.hour.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')}:00';

    return AddAvailabilityRequestModel(
      fromTime: fromStr,
      toTime: toStr,
      specificDate: dateStr,
    );
  }
}