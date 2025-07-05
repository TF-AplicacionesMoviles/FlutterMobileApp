import 'package:dentify_flutter/patientAttention/patients/domain/model/patient.dart';
import 'package:dentify_flutter/patientAttention/patients/presentation/di/presentation_module.dart';
import 'package:dentify_flutter/patientAttention/patients/presentation/widgets/medical_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicalHistoriesView extends ConsumerWidget{
  const MedicalHistoriesView({super.key, required this.patient});
  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicalHistories = ref.watch(medicalHistoriesViewModelProvider(patient.id));
    final isLoading = ref.watch(medicalHistoriesViewModelProvider(patient.id).notifier).isLoading;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Medical Histories",
      style: TextStyle(fontWeight: FontWeight.bold),)),
      body: Column(
        children: [
          Expanded(
              child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : medicalHistories.isEmpty
                  ? const Center(child: Text('No medical histories found.'))
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: medicalHistories.length,
                itemBuilder:(context, index) {
                  final medicalHistory = medicalHistories[index];
                  return MedicalHistoryCard(medicalHistory: medicalHistory);
                },)
            )
            ],
      ),  
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              // final newPatient = await showDialog<AddPatientRequest>(
              //   context: context,
              //   builder: (context) => const PatientForm(),
              // );
              // if (newPatient != null) {
              //   await ref
              //       .read(patientsViewModelProvider.notifier)
              //       .addPatient(newPatient);
              // }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C3E50),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text('Add medical history'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}