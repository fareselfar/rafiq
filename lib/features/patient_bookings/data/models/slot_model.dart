// features/patient_bookings/data/models/slot_model.dart

import '../../domain/entities/slot_entity.dart'; // تأكد من مسار الـ Entity عندك

class SlotModel extends SlotEntity {
  final int rawMinutes; // للترتيب لو حبيت ترتب المواعيد

  const SlotModel({
    required super.id,
    required super.time,
    required super.isReserved,
    required this.rawMinutes,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    final rawTime =
        json['time'] as String? ?? json['fromTime'] as String? ?? '';

    return SlotModel(
      // هنا اتأكدنا إنه int ومستحيل يقلب String
      id: json['id'] as int? ?? 0,
      time: _formatTime(rawTime),
      isReserved: json['isReserved'] ?? json['isClosed'] ?? false,
      rawMinutes: _toMinutes(rawTime),
    );
  }

  static int _toMinutes(String raw) {
    if (raw.isEmpty) return 0;
    try {
      final parts = raw.split(':');
      return int.parse(parts[0]) * 60 + int.parse(parts[1]);
    } catch (_) {
      return 0;
    }
  }

  static String _formatTime(String raw) {
    if (raw.isEmpty) return '';
    try {
      final parts = raw.split(':');
      if (parts.length < 2) return raw;
      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = parts[1].padLeft(2, '0');
      final suffix = hour < 12 ? 'ص' : 'م';
      final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      return '$displayHour:$minute $suffix';
    } catch (_) {
      return raw;
    }
  }
}
