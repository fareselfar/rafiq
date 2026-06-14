import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/edit_profile/data/models/update_profile_request.dart';
import 'package:rafiq/features/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_profile/data/models/update_medical_record_request.dart';
import 'package:rafiq/features/patient_profile/data/models/upload_file_request.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/change_pass_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/get_files_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/profile_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/update_medical_record_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/update_profile_usecase.dart';
import 'package:rafiq/features/patient_profile/domain/usecases/upload_files_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfileUsecase,
    required this.changePassUseCase,
    required this.updateProfileUseCase,
    required this.uploadFileUseCase,
    required this.getFilesUseCase,
    required this.updateMedicalRecordUseCase,
  }) : super(const ProfileInitial());
  final GetProfileUsecase getProfileUsecase;
  final ChangePassUseCase changePassUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadFileUseCase uploadFileUseCase;
  final GetFilesUseCase getFilesUseCase;
  final UpdateMedicalRecordUseCase updateMedicalRecordUseCase;
  void getProfile() async {
    {
      var result = await getProfileUsecase();
      emit(ProfileLoading());
      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
        },
        (profile) {
          emit(ProfileLoaded(profile));
        },
      );
    }
  }

  void changePass({required ChangePassRequest request}) async {
    emit(ProfileLoading());
    {
      var result = await changePassUseCase(request: request);
      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
        },
        (success) {
          emit(
            PasswordChanged(
              message: success.message ?? 'Password changed successfully.',
            ),
          );
        },
      );
    }
  }

  Future<void> updateProfile({required UpdateProfileRequest request}) async {
    emit(UpdateProfileLoading());

    final result = await updateProfileUseCase(request: request);

    result.fold(
      (failure) {
        emit(ProfileError(failure.message));
      },
      (success) {
        emit(ProfileUpdated(success.message ?? "تم تحديث البيانات بنجاح"));
      },
    );
  }

  Future<void> uploadFile({required UploadFileRequest request}) async {
    emit(FilesLoading());

    final result = await uploadFileUseCase(request: request);

    result.fold(
      (failure) {
        emit(FilesError(failure.message));
      },
      (success) {
        emit(FilesUploaded(success.message));
      },
    );
  }

  Future<void> getFiles({String? fileType}) async {
    emit(FilesListLoading());

    final result = await getFilesUseCase(fileType: fileType);

    result.fold(
      (failure) {
        emit(FilesListError(failure.message));
      },
      (files) {
        emit(FilesListLoaded(files));
      },
    );
  }

  Future<void> updateMedicalRecord({
    required UpdateMedicalRecordRequest request,
  }) async {
    emit(MedicalRecordLoading());

    final result = await updateMedicalRecordUseCase(request: request);

    result.fold(
      (failure) {
        emit(MedicalRecordError(failure.message));
      },
      (success) {
        emit(
          MedicalRecordUpdated(success.message ?? 'تم تحديث البيانات بنجاح'),
        );
      },
    );
  }
}
