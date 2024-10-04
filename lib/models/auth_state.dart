class AuthState {
  final bool otpSent;
  final bool isAuthenticated;

  AuthState({this.otpSent = false, this.isAuthenticated = false});

  AuthState copyWith({bool? otpSent, bool? isAuthenticated}) {
    return AuthState(
      otpSent: otpSent ?? false,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
