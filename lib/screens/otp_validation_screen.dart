import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_provider.dart';

class OtpValidationScreen extends HookConsumerWidget {
  const OtpValidationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = useTextEditingController();
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('OTP Validation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).validateOTP(otpController.text);
              },
              child: const Text('Validate OTP'),
            ),
            authState.when(
              data: (state) => state.isAuthenticated
                  ? const Text('Authentication Successful!')
                  : const SizedBox.shrink(),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(
                'Error: ${error.toString()}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
