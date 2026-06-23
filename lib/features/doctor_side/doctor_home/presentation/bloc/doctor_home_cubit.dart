import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/doctor_home_entity.dart';
import '../../domain/usecases/get_doctor_home_data_usecase.dart';

part 'doctor_home_state.dart';

class DoctorHomeCubit extends Cubit<DoctorHomeState> {
  final GetDoctorHomeDataUsecase getDoctorHomeData;

  DoctorHomeCubit({required this.getDoctorHomeData})
      : super(const DoctorHomeInitial());

  Future<void> loadData() async {
    emit(const DoctorHomeLoading());

    final result = await getDoctorHomeData();

    result.fold(
      (failure) => emit(DoctorHomeError(failure.message)),
      (data) => emit(DoctorHomeLoaded(data)),
    );
  }


}