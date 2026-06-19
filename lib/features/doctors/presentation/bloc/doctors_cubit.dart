import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/domain/usecase/get_doctors_usecase.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final GetDoctorsUseCase getDoctorsUseCase;

  DoctorsCubit(this.getDoctorsUseCase) : super(DoctorsInitial());

  Future<void> loadDoctors({String? search}) async {
    emit(DoctorsLoading());
    try {
      final doctors = await getDoctorsUseCase(search: search);
      emit(DoctorsLoaded(doctors));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }
}