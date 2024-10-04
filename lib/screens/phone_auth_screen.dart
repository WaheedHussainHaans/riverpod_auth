import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/auth_state.dart';
import '../providers/auth_provider.dart';
import 'otp_validation_screen.dart';

class PhoneAuthScreen extends HookConsumerWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue<AuthState>>(authProvider, (_, state) {
      state.whenData((value) {
        if (value.otpSent) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const OtpValidationScreen()),
          );
        }
      });
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).sendOTP(phoneController.text);
              },
              child: const Text('Send OTP'),
            ),
            authState.when(
              data: (_) => const SizedBox.shrink(),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
