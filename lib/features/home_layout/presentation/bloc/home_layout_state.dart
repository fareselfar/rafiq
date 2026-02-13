part of 'home_layout_cubit.dart';

abstract class HomeLayoutState extends Equatable {
  const HomeLayoutState();

  @override
  List<Object> get props => [];
}

class HomeLayoutInitial extends HomeLayoutState {
  const HomeLayoutInitial();
}

class HomeLayoutLoading extends HomeLayoutState {}

class HomeLayoutLoaded extends HomeLayoutState {}

class HomeLayoutError extends HomeLayoutState {
  final String message;
  const HomeLayoutError(this.message);

  @override
  List<Object> get props => [message];
}

