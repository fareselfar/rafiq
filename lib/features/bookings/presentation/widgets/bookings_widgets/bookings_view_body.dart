import 'package:flutter/material.dart';
import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/features/bookings/presentation/widgets/bookings_widgets/bookings_list_view.dart';

class BookingsViewBody extends StatelessWidget {
  const BookingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        BookingsListView(filterStatus: null), 
        BookingsListView(filterStatus: BookingStatus.upcoming), 
        BookingsListView(filterStatus: BookingStatus.completed), 
      ],
    );
  }
}
