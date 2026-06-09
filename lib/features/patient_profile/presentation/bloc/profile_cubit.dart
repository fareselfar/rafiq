import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/profile/domain/usecases/profile_usecase.dart';
import 'profile_state.dart';
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.getProfileUsecase})
    : super(const ProfileInitial());
  final GetProfileUsecase getProfileUsecase;
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
}
