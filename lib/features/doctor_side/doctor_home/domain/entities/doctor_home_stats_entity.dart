class DoctorHomeStatsEntity {
  final int weeklyAppointments;
  final int todayBookings;
  final double monthlyEarnings;
  final double rating;

  const DoctorHomeStatsEntity({
    required this.weeklyAppointments,
    required this.todayBookings,
    required this.monthlyEarnings,
    required this.rating,
  });
}