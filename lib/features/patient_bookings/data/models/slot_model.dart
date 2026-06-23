// features/patient_bookings/data/models/slot_model.dart

class SlotModel {
  final int id;
  final String time;
  final bool isReserved;
  final int rawMinutes; // للترتيب — مش للعرض

  const SlotModel({
    required this.id,
    required this.time,
    required this.isReserved,
    required this.rawMinutes,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    // الباك PatientForAvailableSlotDto بيبعت:
    // { "id": 1, "time": "13:00:00", "isReserved": false }
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

  /// "13:00:00" → 780 (للترتيب)
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
