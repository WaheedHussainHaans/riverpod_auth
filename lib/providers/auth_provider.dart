import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// State providers for input values
final phoneNumberProvider = StateProvider<String>((ref) => '');
final otpProvider = StateProvider<String>((ref) => '');

// Trigger providers
final sendOtpTriggerProvider = StateProvider<bool>((ref) => false);
final validateOtpTriggerProvider = StateProvider<bool>((ref) => false);

// Send OTP provider
final sendOtpProvider = FutureProvider<String>((ref) async {
  final shouldRun = ref.watch(sendOtpTriggerProvider);
  final phoneNumber = ref.watch(phoneNumberProvider);

  if (!shouldRun || phoneNumber.isEmpty) {
    return ''; // Return empty string if we shouldn't run or phone number is empty
  }

  final authService = ref.read(authServiceProvider);
  await authService.sendOTP(phoneNumber);
  return 'OTP sent successfully';
});

// Validate OTP provider
final validateOtpProvider = FutureProvider<String>((ref) async {
  final shouldRun = ref.watch(validateOtpTriggerProvider);
  final otp = ref.watch(otpProvider);

  if (!shouldRun || otp.isEmpty) {
    return ''; // Return empty string if we shouldn't run or OTP is empty
  }

  final authService = ref.read(authServiceProvider);
  final isValid = await authService.validateOTP(otp);
  return isValid ? 'OTP validated successfully' : 'Invalid OTP';
});
