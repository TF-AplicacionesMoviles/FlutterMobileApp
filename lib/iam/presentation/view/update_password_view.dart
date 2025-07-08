import 'package:dentify_flutter/iam/presentation/di/presentation_module.dart';
import 'package:dentify_flutter/iam/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/remote/dto/update_password_request.dart';

class UpdatePasswordView extends ConsumerWidget {
  final ProfileViewModel viewModel;

  const UpdatePasswordView({super.key, required this.viewModel});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(profileViewModelProvider.notifier);
    final state = ref.watch(profileViewModelProvider);

    final currentPass = TextEditingController();
    final newPass = TextEditingController();
    final confirmPass = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: currentPass, obscureText: true, decoration: const InputDecoration(labelText: 'Current Password')),
            TextField(controller: newPass, obscureText: true, decoration: const InputDecoration(labelText: 'New Password')),
            TextField(controller: confirmPass, obscureText: true, decoration: const InputDecoration(labelText: 'Confirm Password')),
            if (state.errorMessage != null)
              Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                if (newPass.text != confirmPass.text) {
                  viewModel.setError("Passwords do not match.");
                  return;
                }

                await viewModel.updatePassword(
                  UpdatePasswordRequest(oldPassword: currentPass.text, newPassword: newPass.text),
                );

                if (ref.read(profileViewModelProvider).errorMessage == null) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Update Password"),
            ),
          ],
        ),
      ),
    );
  }
}
