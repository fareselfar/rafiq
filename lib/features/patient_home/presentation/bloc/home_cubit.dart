import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/features/patient_home/domain/entities/search_doctor_entity.dart';
import 'package:rafiq/features/patient_home/domain/usecases/search_doctor_usecase.dart';

part 'home_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchDoctorsUseCase}) : super(SearchInitial());
  final SearchDoctorsUseCase searchDoctorsUseCase;
  Future<void> search(String query) async {
    emit(SearchLoading());

    final result = await searchDoctorsUseCase(query: query);

    result.fold(
      (failure) {
        emit(SearchError(failure.message));
      },
      (success) {
        emit(SearchLoaded(success));
      },
    );
  }
}
