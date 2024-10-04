import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// State providers for input values
final phoneNumberProvider = StateProvider<String>((ref) => '');
final otpProvider = StateProvider<String>((ref) => '');

// Send OTP provider
final sendOtpProvider = FutureProvider.autoDispose<void>((ref) async {
  // This will prevent the FutureProvider from running automatically
  // It will only run when manually refreshed
  ref.keepAlive(); // = true;

  final phoneNumber = ref.watch(phoneNumberProvider);
  if (phoneNumber.isEmpty) throw Exception('Phone number is empty');

  final authService = ref.watch(authServiceProvider);
  await authService.sendOTP(phoneNumber);
});

// Validate OTP provider
final validateOtpProvider = FutureProvider.autoDispose<bool>((ref) async {
  // This will prevent the FutureProvider from running automatically
  // It will only run when manually refreshed
  ref.keepAlive();
  // maintainState = true;

  final otp = ref.watch(otpProvider);
  if (otp.isEmpty) throw Exception('Phone number is empty');

  final authService = ref.watch(authServiceProvider);
  return await authService.validateOTP(otp);
});
