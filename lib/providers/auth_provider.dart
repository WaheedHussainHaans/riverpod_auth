import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../services/auth_service.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState());

  Future<void> sendOTP(String phoneNumber) async {
    state = state.copyWith(isLoading: true, error: null, otpSent: false);
    try {
      await _authService.sendOTP(phoneNumber);
      state = state.copyWith(isLoading: false, otpSent: true, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> validateOTP(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final isValid = await _authService.validateOTP(otp);
      state = state.copyWith(isLoading: false, isAuthenticated: isValid);
      if (!isValid) {
        state = state.copyWith(error: 'Invalid OTP. Please try again.');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = AuthService();
  return AuthNotifier(authService);
});
