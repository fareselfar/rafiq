// features/patient_bookings/data/models/slot_model.dart
class SlotModel {
  final int id;
  final String time;
  final bool isReserved;

  const SlotModel({
    required this.id,
    required this.time,
    required this.isReserved,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    final rawTime = json['fromTime'] as String? ?? ''; 
  return SlotModel(
    id: json['id'] ?? 0,
    time: _formatTime(rawTime),
    isReserved: json['isClosed'] ?? false,
  );
  }

  static String _formatTime(String raw) {
    if (raw.isEmpty) return '';
    final parts = raw.split(':');
    if (parts.length < 2) return raw;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = parts[1];
    final suffix = hour < 12 ? 'ص' : 'م';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '$displayHour:$minute $suffix';
  }
}
