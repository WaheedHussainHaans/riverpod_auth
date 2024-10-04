import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_provider.dart';
import 'otp_validation_screen.dart';

class PhoneAuthScreen extends ConsumerWidget {
  final TextEditingController _phoneController = TextEditingController();

  PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sendOtpState = ref.watch(sendOtpProvider);

    ref.listen<AsyncValue<void>>(sendOtpProvider, (_, state) {
      state.whenData((_) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => OtpValidationScreen()),
        );
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
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendOtpState.isLoading
                  ? null
                  : () {
                      ref.read(phoneNumberProvider.notifier).state =
                          _phoneController.text;
                      ref.refresh(sendOtpProvider);
                    },
              child: sendOtpState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Send OTP'),
            ),
            const SizedBox(height: 20),
            if (sendOtpState.hasError)
              Text(sendOtpState.error.toString(),
                  style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
