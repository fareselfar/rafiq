enum BookingStatus { pending, upcoming, completed, cancelled }

extension BookingStatusX on String {
  BookingStatus toBookingStatus() {
    switch (toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'upcoming':
        return BookingStatus.upcoming;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
      case 'canceled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending; 
    }
  }
}