// features/patient_bookings/domain/entities/slot_entity.dart
class SlotEntity {
  final int id;
  final String time;
  final bool isReserved;

  const SlotEntity({
    required this.id,
    required this.time,
    required this.isReserved,
  });
}