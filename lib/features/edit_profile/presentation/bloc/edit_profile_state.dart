part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {
  const EditProfileInitial();
}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;
  const EditProfileError(this.message);

  @override
  List<Object> get props => [message];
}
