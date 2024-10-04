import '../utils/constants.dart';

class AuthService {
  Future<void> sendOTP(String phoneNumber) async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulating network delay
    if (phoneNumber != VALID_PHONE_NUMBER) {
      throw Exception('Invalid phone number');
    }
  }

  Future<bool> validateOTP(String otp) async {
    await Future.delayed(
        const Duration(seconds: 1)); // Simulating network delay
    return otp == VALID_OTP;
  }
}
