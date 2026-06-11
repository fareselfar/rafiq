import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/patient_side/patient_profile/data/models/Change_pass_request.dart';
import 'package:rafiq/features/patient_side/patient_profile/domain/usecases/change_pass_usecase.dart';
import 'package:rafiq/features/patient_side/patient_profile/domain/usecases/profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfileUsecase,
    required this.changePassUseCase,
  }) : super(const ProfileInitial());
  final GetProfileUsecase getProfileUsecase;
  final ChangePassUseCase changePassUseCase;
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
    {
      var result = await changePassUseCase(request: request);
      emit(ProfileLoading());
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
}
