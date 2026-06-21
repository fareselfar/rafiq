import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthSharedPrefs _prefs;

  SplashCubit({required AuthSharedPrefs prefs})
      : _prefs = prefs,
        super(const SplashInitial());

  Future<void> checkSession() async {
    await Future.delayed(const Duration(seconds: 2));

    final isFirst = await _prefs.isFirstLaunch();
    if (isFirst) {
      await _prefs.setLaunched();
      emit(const SplashFirstLaunch());
      return;
    }

    final token = await _prefs.getToken();
    if (token.isEmpty) {
      emit(const SplashUnauthenticated());
      return;
    }

    if (JwtDecoder.isExpired(token)) {
      await _prefs.clearAll();
      emit(const SplashUnauthenticated());
      return;
    }

    final role = await _prefs.getRole();
    final isDoctor = role.toLowerCase() == 'doctor';
    emit(SplashAuthenticated(isDoctor: isDoctor));
  }
}