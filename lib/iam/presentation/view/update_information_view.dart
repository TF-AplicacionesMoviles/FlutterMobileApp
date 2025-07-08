import 'package:dentify_flutter/iam/data/remote/dto/update_infomation_request.dart';
import 'package:dentify_flutter/iam/presentation/di/presentation_module.dart';
import 'package:dentify_flutter/iam/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateInformationView extends ConsumerWidget {
  final ProfileViewModel viewModel;

  const UpdateInformationView({super.key, required this.viewModel});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(profileViewModelProvider.notifier);
    final state = ref.watch(profileViewModelProvider);

    final fullNameParts = (state.userInfo?.fullName ?? '').split(" ");
    final firstNameController = TextEditingController(text: fullNameParts.firstOrNull ?? '');
    final lastNameController = TextEditingController(text: fullNameParts.length > 1 ? fullNameParts.last : '');
    final emailController = TextEditingController(text: state.userInfo?.email ?? '');
    final companyController = TextEditingController(text: state.userInfo?.companyName ?? '');

    return Scaffold(
      appBar: AppBar(title: const Text('Update Info')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: firstNameController, decoration: const InputDecoration(labelText: 'First Name')),
            TextField(controller: lastNameController, decoration: const InputDecoration(labelText: 'Last Name')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: companyController, decoration: const InputDecoration(labelText: 'Company Name')),
            if (state.errorMessage != null)
              Text("Error: ${state.errorMessage}", style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                await viewModel.updateInformation(
                  UpdateInformationRequest(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    companyName: companyController.text,
                  ),
                );
                if (ref.read(profileViewModelProvider).errorMessage == null) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}