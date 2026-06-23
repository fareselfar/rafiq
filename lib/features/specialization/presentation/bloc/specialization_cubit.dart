import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/specialization/domain/usecase/get_specialization_usecase.dart';
import 'package:rafiq/features/specialization/presentation/bloc/specialization_state.dart';

class SpecializationCubit extends Cubit<SpecializationState> {
  final GetSpecializationsUseCase getSpecializationsUseCase;

  SpecializationCubit({required this.getSpecializationsUseCase})
    : super(SpecializationInitial());

  Future<void> getSpecializations() async {
    print("GET SPECIALIZATIONS START");
    emit(SpecializationLoading());

    final result = await getSpecializationsUseCase();
    print("GET SPECIALIZATIONS END");
    result.fold(
      (failure) {
        emit(SpecializationError(failure.message));
      },
      (data) {
        emit(SpecializationLoaded(data));
      },
    );
  }
}