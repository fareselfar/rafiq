import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'specialization_state.dart';

class SpecializationCubit extends Cubit<SpecializationState> {
  SpecializationCubit() : super(const SpecializationInitial());

  void loadData() {
    // TODO: implement load data logic
  }
}
