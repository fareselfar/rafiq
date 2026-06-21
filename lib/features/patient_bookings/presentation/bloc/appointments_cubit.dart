import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_state.dart';

import '../../domain/usecases/patient_bookings_usecases.dart' as patient_uc;

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final patient_uc.GetMyAppointmentsUseCase getAppointmentsUseCase;
  final patient_uc.GetAppointmentDetailsUseCase getDetailsUseCase;
  final patient_uc.CancelAppointmentUseCase cancelUseCase;
  final patient_uc.RescheduleAppointmentUseCase rescheduleUseCase;

  AppointmentsCubit({
    required this.getAppointmentsUseCase,
    required this.getDetailsUseCase,
    required this.cancelUseCase,
    required this.rescheduleUseCase,
  }) : super(AppointmentsInitial());

  Future<void> loadAppointments({String? status}) async {
    emit(AppointmentsLoading());
    try {
      final list = await getAppointmentsUseCase(status: status);
      emit(AppointmentsLoaded(list));
    } catch (e) {
      emit(AppointmentsError('فشل تحميل الحجوزات'));
    }
  }

  Future<void> loadDetails(int appointmentId) async {
    emit(AppointmentDetailsLoading());
    try {
      final details = await getDetailsUseCase(appointmentId);
      emit(AppointmentDetailsLoaded(details));
    } catch (e) {
      emit(AppointmentsError('فشل تحميل التفاصيل'));
    }
  }

  Future<void> cancelAppointment(int appointmentId) async {
    emit(CancelInProgress());
    try {
      await cancelUseCase(appointmentId);
      emit(CancelSuccess());
    } catch (e) {
      emit(ActionError('فشل إلغاء الحجز'));
    }
  }

  Future<void> rescheduleAppointment(int appointmentId, int slotId) async {
    emit(RescheduleInProgress());
    try {
      await rescheduleUseCase(appointmentId, slotId);
      emit(RescheduleSuccess());
    } catch (e) {
      emit(ActionError('فشل تعديل الموعد'));
    }
  }
}
