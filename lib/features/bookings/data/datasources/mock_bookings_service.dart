import 'package:rafiq/core/enums/booking__status.dart';
import 'package:rafiq/features/bookings/data/models/bookings_model.dart';
import 'package:rafiq/features/doctors/data/datasources/mock_doctors_service.dart';

class MockBookingsService {
  static List<BookingModel> get dummyBookings => [
    BookingModel(
      id: "1",
      date: DateTime.now().add(const Duration(days: 2)),
      time: "10:30 ص",
      subTotal: 150,
      discount: 0,
      totalPrice: 150,
      status: BookingStatus.upcoming,
      doctor: MockDoctorsService.dummyDoctors[0],
    ),

    BookingModel(
      id: "2",
      date: DateTime.now().subtract(const Duration(days: 5)),
      time: "08:00 م",
      subTotal: 250,
      discount: 50,
      totalPrice: 200,
      status: BookingStatus.completed,
      doctor: MockDoctorsService.dummyDoctors[1],
    ),

    BookingModel(
      id: "3",
      date: DateTime.now().add(const Duration(days: 1)),
      time: "01:00 م",
      subTotal: 200,
      discount: 20,
      totalPrice: 180,
      status: BookingStatus.upcoming,
      doctor: MockDoctorsService.dummyDoctors[2],
    ),

    BookingModel(
      id: "4",
      date: DateTime.now().subtract(const Duration(days: 10)),
      time: "05:00 م",
      subTotal: 300,
      discount: 0,
      totalPrice: 300,
      status: BookingStatus.cancelled,
      doctor: MockDoctorsService.dummyDoctors[3],
    ),

    BookingModel(
      id: "5",
      date: DateTime.now().add(const Duration(days: 15)),
      time: "12:00 م",
      subTotal: 150,
      discount: 10,
      totalPrice: 140,
      status: BookingStatus.upcoming,
      doctor: MockDoctorsService.dummyDoctors[0],
    ),
  ];
}
