enum DoctorAppointmentStatus {
  pending('pending'),
  confirmed('confirmed'),
  cancelled('cancelled'),
  completed('completed');

  final String value;
  const DoctorAppointmentStatus(this.value);

  static DoctorAppointmentStatus fromString(String? status) {
    return DoctorAppointmentStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => DoctorAppointmentStatus.pending,
    );
  }
}