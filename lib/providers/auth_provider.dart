import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state.dart';
import '../services/auth_service.dart';

class AuthNotifier extends AsyncNotifier<AuthState> {
  late final AuthService _authService;

  @override
  FutureOr<AuthState> build() {
    _authService = AuthService();
    return AuthState();
  }

  Future<void> sendOTP(String phoneNumber) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authService.sendOTP(phoneNumber);
      return state.value!.copyWith(otpSent: true);
    });
  }

  Future<void> validateOTP(String otp) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final isValid = await _authService.validateOTP(otp);
      return state.value!.copyWith(isAuthenticated: isValid);
    });
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
