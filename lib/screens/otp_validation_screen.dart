import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_provider.dart';

class OtpValidationScreen extends ConsumerWidget {
  final TextEditingController _otpController = TextEditingController();

  OtpValidationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validateOtpState = ref.watch(validateOtpProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('OTP Validation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: validateOtpState.isLoading
                  ? null
                  : () {
                      ref.read(otpProvider.notifier).state =
                          _otpController.text;
                      ref.read(validateOtpTriggerProvider.notifier).state =
                          true;
                    },
              child: validateOtpState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Validate OTP'),
            ),
            const SizedBox(height: 20),
            if (validateOtpState.hasValue && validateOtpState.value!.isNotEmpty)
              Text(
                validateOtpState.value!,
                style: TextStyle(
                    color:
                        validateOtpState.value! == 'OTP validated successfully'
                            ? Colors.green
                            : Colors.red),
              ),
            if (validateOtpState.hasError)
              Text(validateOtpState.error.toString(),
                  style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
