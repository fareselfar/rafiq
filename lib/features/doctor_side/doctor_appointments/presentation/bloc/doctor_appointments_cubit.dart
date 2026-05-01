import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  DoctorAppointmentsCubit() : super(const DoctorAppointmentsInitial());

  void loadData() {
    // TODO: implement load data logic
  }
}
