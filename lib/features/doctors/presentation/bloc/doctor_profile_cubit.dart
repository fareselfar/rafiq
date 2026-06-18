import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/domain/usecase/get_doctors_usecase.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final GetDoctorProfileUseCase getProfileUseCase;

  DoctorProfileCubit(this.getProfileUseCase) : super(DoctorProfileInitial());

  Future<void> loadProfile(int doctorId) async {
    emit(DoctorProfileLoading());
    try {
      final profile = await getProfileUseCase(doctorId);
      emit(DoctorProfileLoaded(profile));
    } catch (e) {
      emit(DoctorProfileError(e.toString()));
    }
  }
}