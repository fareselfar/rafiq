import 'package:flutter/material.dart';

class LoadingBookings extends StatelessWidget {
  const LoadingBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
