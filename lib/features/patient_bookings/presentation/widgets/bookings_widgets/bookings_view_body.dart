import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/bookings_widgets/bookings_list_view.dart';

class BookingsViewBody extends StatefulWidget {
  const BookingsViewBody({super.key});

  @override
  State<BookingsViewBody> createState() => _BookingsViewBodyState();
}

class _BookingsViewBodyState extends State<BookingsViewBody> {
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = DefaultTabController.of(context);
    if (controller != _tabController) {
      _tabController?.removeListener(_handleTabSelection);
      _tabController = controller;
      _tabController?.addListener(_handleTabSelection);
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController != null && !_tabController!.indexIsChanging) {
      final cubit = context.read<AppointmentsCubit>();
      switch (_tabController!.index) {
        case 0:
          cubit.loadAppointments();
          break;
        case 1:
          cubit.loadAppointments(status: 'Pending'); 
          break;
        case 2:
          cubit.loadAppointments(status: 'Completed');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        BookingsListView(),
        BookingsListView(),
        BookingsListView(),
      ],
    );
  }
}