import '../utils/constants.dart';

class AuthService {
  Future<void> sendOTP(String phoneNumber) async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating network delay
    if (phoneNumber != AppConstants.validPhone) {
      throw Exception('Invalid phone number');
    }
  }

  Future<bool> validateOTP(String otp) async {
    await Future.delayed(
        const Duration(seconds: 1)); // Simulating network delay
    if (otp != AppConstants.validOtp) {
      throw Exception('Invalid OTP');
    }
    return otp == AppConstants.validOtp;
  }
}
