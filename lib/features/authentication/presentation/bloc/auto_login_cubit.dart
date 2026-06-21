import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/authentication/domain/usecases/auto_login_usecase.dart';
import 'package:rafiq/features/authentication/presentation/bloc/auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  final AutoLoginUseCase _autoLoginUseCase;

  AutoLoginCubit({required AutoLoginUseCase autoLoginUseCase})
      : _autoLoginUseCase = autoLoginUseCase,
        super(const AutoLoginInitial());

  Future<void> checkSession() async {
    emit(const AutoLoginLoading());
    final result = await _autoLoginUseCase();
    switch (result) {
      case AutoLoginResult.patientLoggedIn:
        emit(const AutoLoginAuthenticated(role: 'Patient'));
      case AutoLoginResult.doctorLoggedIn:
        emit(const AutoLoginAuthenticated(role: 'Doctor'));
      case AutoLoginResult.tokenExpired:
        emit(const AutoLoginExpired());
      case AutoLoginResult.notLoggedIn:
        emit(const AutoLoginUnauthenticated());
    }
  }
}