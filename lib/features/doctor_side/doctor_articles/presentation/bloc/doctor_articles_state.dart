part of 'doctor_articles_cubit.dart';

abstract class DoctorArticlesState extends Equatable {
  const DoctorArticlesState();

  @override
  List<Object> get props => [];
}

class DoctorArticlesInitial extends DoctorArticlesState {
  const DoctorArticlesInitial();
}

class DoctorArticlesLoading extends DoctorArticlesState {}

class DoctorArticlesLoaded extends DoctorArticlesState {}

class DoctorArticlesError extends DoctorArticlesState {
  final String message;
  const DoctorArticlesError(this.message);

  @override
  List<Object> get props => [message];
}
