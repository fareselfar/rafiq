import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'homee_state.dart';

class HomeeCubit extends Cubit<HomeeState> {
  HomeeCubit() : super(const HomeeInitial());

  void loadData() {
    // TODO: implement load data logic
  }
}
