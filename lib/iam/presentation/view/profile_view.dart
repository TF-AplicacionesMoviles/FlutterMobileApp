import 'package:dentify_flutter/iam/presentation/di/presentation_module.dart';
import 'package:dentify_flutter/iam/presentation/viewmodel/profile_view_model.dart';
import 'package:dentify_flutter/iam/presentation/widgets/profile_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  final ProfileViewModel viewModel;
  const ProfileView({super.key, required this.viewModel});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    // Llama a fetchUserInfo solo una vez al inicializar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).fetchUserInfo();
    });
  }

@override
Widget build(BuildContext context) {
  final state = ref.watch(profileViewModelProvider.select((state) => state)); // Observa todo el estado
  final isLoading = ref.watch(profileViewModelProvider.select((state) => state.isLoading));
  final userInfo = ref.watch(profileViewModelProvider.select((state) => state.userInfo));
  final errorMessage = ref.watch(profileViewModelProvider.select((state) => state.errorMessage));

  return Scaffold(
    appBar: AppBar(title: const Text('Profile')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userInfo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profile Information",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    if (errorMessage != null)
                      Text(
                        "Error: $errorMessage",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ProfileField(label: "Full Name", value: userInfo.fullName),
                    ProfileField(label: "Username", value: userInfo.username),
                    ProfileField(label: "Email", value: userInfo.email),
                    ProfileField(label: "Company", value: userInfo.companyName),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, 'update-info'),
                      child: const Text("Update Information"),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, 'update-password'),
                      child: const Text("Change Password"),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    errorMessage ?? "No se pudo cargar la información del perfil",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
    ),
  );
}}