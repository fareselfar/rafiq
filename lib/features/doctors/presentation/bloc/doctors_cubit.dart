import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/doctors/domain/entities/doctors_entity.dart';
import 'package:rafiq/features/doctors/domain/usecase/get_doctors_usecase.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/app_bar/filter_chips_section.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final GetDoctorsUseCase getDoctorsUseCase;

  DoctorsCubit(this.getDoctorsUseCase) : super(DoctorsInitial());

  List<DoctorEntity> _allDoctors = [];
  DoctorFilter _currentFilter = DoctorFilter.nearest;

  Future<void> loadDoctors({String? search}) async {
    emit(DoctorsLoading());
    try {
      final doctors = await getDoctorsUseCase(search: search);
      _allDoctors = doctors;
      emit(DoctorsLoaded(_applyFilter(_allDoctors, _currentFilter), _currentFilter));
    } catch (e) {
      emit(DoctorsError(e.toString()));
    }
  }

  void changeFilter(DoctorFilter filter) {
    _currentFilter = filter;
    emit(DoctorsLoaded(_applyFilter(_allDoctors, filter), filter));
  }

  List<DoctorEntity> _applyFilter(List<DoctorEntity> doctors, DoctorFilter filter) {
    final list = List<DoctorEntity>.from(doctors);
    switch (filter) {
      case DoctorFilter.topRated:
        list.sort((a, b) => b.rate.compareTo(a.rate));
        break;
      case DoctorFilter.availableToday:
        list.sort((a, b) {
          if (a.isAvailableToday == b.isAvailableToday) return 0;
          return a.isAvailableToday ? -1 : 1;
        });
        break;
      case DoctorFilter.nearest:
        // مفيش بيانات geo حالياً، فبيرجع الترتيب الأصلي من الباك
        break;
    }
    return list;
  }
}