import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_clinic_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_doctor_profile_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/update_payment_info_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/change_doctor_pass_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/create_coupon_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/profile_doctor_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/update_clinic_record_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/update_doctor_profile_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/uscases/update_payment_info_usecase.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_state.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit({
    required this.getProfileUsecase,
    required this.changePassUseCase,
    required this.updateDoctorProfileUseCase,
    required this.updateClinicInfoUseCase,
    required this.createCouponUseCase,
    required this.updatePaymentInfoUseCase,
  }) : super(DoctorProfileInitial());
  final GetProfileDoctorUsecase getProfileUsecase;
  final ChangeDoctorPassUseCase changePassUseCase;
  final UpdateDoctorProfileUseCase updateDoctorProfileUseCase;
  final UpdateClinicInfoUseCase updateClinicInfoUseCase;
  final CreateCouponUseCase createCouponUseCase;
  final UpdatePaymentInfoUseCase updatePaymentInfoUseCase;
  void getDoctorProfile() async {
    {
      var result = await getProfileUsecase();
      emit(DoctorProfileLoading());
      result.fold(
        (failure) {
          emit(DoctorProfileError(failure.message));
        },
        (profile) {
          emit(DoctorProfileLoaded(profile));
        },
      );
    }
  }

  void changeDoctorPass({required ChangePassRequest request}) async {
    emit(DoctorProfileLoading());
    {
      var result = await changePassUseCase(request: request);
      result.fold(
        (failure) {
          emit(DoctorProfileError(failure.message));
        },
        (success) {
          emit(
            DoctorPasswordChanged(
              message: success.message ?? 'Password changed successfully.',
            ),
          );
        },
      );
    }
  }

  Future<void> updateDoctorProfile({
    required UpdateDoctorProfileRequest request,
  }) async {
    emit(UpdateDoctorProfileLoading());

    final result = await updateDoctorProfileUseCase(request: request);

    result.fold(
      (failure) {
        emit(DoctorProfileError(failure.message));
      },
      (success) {
        emit(
          DoctorProfileUpdated(success.message ?? "تم تحديث البيانات بنجاح"),
        );
      },
    );
  }

  Future<void> updateClinicInfo({
    required UpdateClinicInfoRequest request,
  }) async {
    emit(UpdateClinicInfoLoading());

    final result = await updateClinicInfoUseCase(request: request);

    result.fold(
      (failure) {
        emit(UpdateClinicInfoError(message: failure.message));
      },
      (success) {
        emit(UpdateClinicInfoSuccess(message: success.message));
      },
    );
  }

  Future<void> createCoupon({required CreateCouponRequest request}) async {
    emit(CouponLoading());

    final result = await createCouponUseCase(request: request);

    result.fold(
      (failure) {
        emit(CouponError(failure.message));
      },
      (success) {
        emit(
          CouponSuccess(
            message: success.message ?? "Coupon Created Successfully",
          ),
        );
      },
    );
  }

  Future<void> updatePaymentInfo({
    required UpdatePaymentInfoRequest request,
  }) async {
    emit(PaymentLoading());

    final result = await updatePaymentInfoUseCase(request: request);

    result.fold(
      (failure) {
        emit(PaymentError(failure.message));
      },
      (success) {
        emit(
          PaymentSuccess(
            message: success.message ?? "Payment info updated successfully",
          ),
        );
      },
    );
  }
}
