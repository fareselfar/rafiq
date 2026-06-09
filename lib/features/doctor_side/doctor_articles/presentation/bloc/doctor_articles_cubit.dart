import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_articles_state.dart';

class DoctorArticlesCubit extends Cubit<DoctorArticlesState> {
  DoctorArticlesCubit() : super(const DoctorArticlesInitial());

  void loadData() {
    // TODO: implement load data logic
  }
}
