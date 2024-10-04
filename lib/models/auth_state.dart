class AuthState {
  final bool isLoading;
  final bool otpSent;
  final bool isAuthenticated;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.otpSent = false,
    this.isAuthenticated = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? otpSent,
    bool? isAuthenticated,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      otpSent: otpSent ?? this.otpSent,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
    );
  }
}
