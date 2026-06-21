sealed class AutoLoginState {
  const AutoLoginState();
}

class AutoLoginInitial extends AutoLoginState {
  const AutoLoginInitial();
}

class AutoLoginLoading extends AutoLoginState {
  const AutoLoginLoading();
}

class AutoLoginAuthenticated extends AutoLoginState {
  final String role;
  const AutoLoginAuthenticated({required this.role});
}

class AutoLoginUnauthenticated extends AutoLoginState {
  const AutoLoginUnauthenticated();
}

class AutoLoginExpired extends AutoLoginState {
  const AutoLoginExpired();
}