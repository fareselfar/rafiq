import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_home_layout_state.dart';

class DoctorHomeLayoutCubit extends Cubit<DoctorHomeLayoutState> {
  DoctorHomeLayoutCubit() : super(const DoctorHomeLayoutInitial());

  void loadData() {
    // TODO: implement load data logic
  }
}
