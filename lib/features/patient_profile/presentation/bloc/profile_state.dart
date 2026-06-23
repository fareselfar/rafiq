import 'package:equatable/equatable.dart';
import 'package:rafiq/features/patient_profile/data/models/medical_file_response.dart';
import 'package:rafiq/features/patient_profile/domain/entities/ProfileEntity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class PasswordChanged extends ProfileState {
  final String message;
  const PasswordChanged({required this.message});

  //@override
  //List<Object> get props => [profile];
}

class ProfileUpdated extends ProfileState {
  final String message;

  const ProfileUpdated(this.message);
}

class UpdateProfileLoading extends ProfileState {}

class ChangePasswordLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class FilesInitial extends ProfileState {}

class FilesLoading extends ProfileState {}

class FilesUploaded extends ProfileState {
  final String message;

  const FilesUploaded(this.message);
}

class FilesError extends ProfileState {
  final String message;

  const FilesError(this.message);
}

class FilesListLoading extends ProfileState {}

class FilesListLoaded extends ProfileState {
  final List<MedicalFileResponse> files;

  const FilesListLoaded(this.files);
}

class FilesListError extends ProfileState {
  final String message;

  const FilesListError(this.message);
}

class MedicalRecordLoading extends ProfileState {}

class MedicalRecordUpdated extends ProfileState {
  final String message;

  const MedicalRecordUpdated(this.message);
}

class MedicalRecordError extends ProfileState {
  final String message;

  const MedicalRecordError(this.message);
}
