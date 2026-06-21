part of 'splash_cubit.dart';

sealed class SplashState {
  const SplashState();
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashFirstLaunch extends SplashState {
  const SplashFirstLaunch();
}

class SplashAuthenticated extends SplashState {
  final bool isDoctor;
  const SplashAuthenticated({required this.isDoctor});
}

class SplashUnauthenticated extends SplashState {
  const SplashUnauthenticated();
}