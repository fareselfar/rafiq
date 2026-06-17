import 'package:equatable/equatable.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';

abstract class DoctorProfileState extends Equatable {
  const DoctorProfileState();

  @override
  List<Object> get props => [];
}

class DoctorProfileInitial extends DoctorProfileState {
  const DoctorProfileInitial();
}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileLoaded extends DoctorProfileState {
  final DoctorProfileEntity profile;

  const DoctorProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class DoctorPasswordChanged extends DoctorProfileState {
  final String message;
  const DoctorPasswordChanged({required this.message});

  //@override
  //List<Object> get props => [profile];
}

class DoctorProfileUpdated extends DoctorProfileState {
  final String message;

  const DoctorProfileUpdated(this.message);
}

class UpdateDoctorProfileLoading extends DoctorProfileState {}

class ChangeDoctorPasswordLoading extends DoctorProfileState {}

class DoctorProfileError extends DoctorProfileState {
  final String message;
  const DoctorProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateClinicInfoLoading extends DoctorProfileState {}

class UpdateClinicInfoSuccess extends DoctorProfileState {
  final String message;

  const UpdateClinicInfoSuccess({required this.message});
}

class UpdateClinicInfoError extends DoctorProfileState {
  final String message;

  const UpdateClinicInfoError({required this.message});
}

class CouponLoading extends DoctorProfileState {}

class CouponSuccess extends DoctorProfileState {
  final String message;

  const CouponSuccess({required this.message});
}

class CouponError extends DoctorProfileState {
  final String message;

  const CouponError(this.message);
}

class PaymentLoading extends DoctorProfileState {}

class PaymentSuccess extends DoctorProfileState {
  final String message;

  const PaymentSuccess({required this.message});
}

class PaymentError extends DoctorProfileState {
  final String message;

  const PaymentError(this.message);
}
