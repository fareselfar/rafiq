import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/features/bookings/data/datasources/mock_bookings_service.dart';
import 'package:rafiq/core/enums/booking__status.dart';

import 'booking_card.dart';

class BookingsListView extends StatelessWidget {
  final BookingStatus? filterStatus;
  const BookingsListView({super.key, this.filterStatus});

  @override
  Widget build(BuildContext context) {
    final allBookings = MockBookingsService.dummyBookings;

    final filteredList = filterStatus == null
        ? allBookings
        : allBookings.where((b) => b.status == filterStatus).toList();

    if (filteredList.isEmpty) {
      return Center(
        child: Text("لا توجد حجوزات حالياً", style: AppTypography.bodyLarge),
      );
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) =>
          BookingCard(booking: filteredList[index]),
    );
  }

  
}
