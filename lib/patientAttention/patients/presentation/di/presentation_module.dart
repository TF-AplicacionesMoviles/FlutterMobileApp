import 'package:dentify_flutter/patientAttention/patients/data/di/dependency_injection.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/model/patient.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/add_patient_use_case.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/delete_patient_use_case.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/get_all_patients_use_case.dart';
import 'package:dentify_flutter/patientAttention/patients/presentation/viewmodel/patient_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final getAllPatientsUseCaseProvider = Provider<GetAllPatientsUseCase>((ref) {
  return GetAllPatientsUseCase(ref.read(patientRepositoryProvider));
});

final addPatientUseCaseProvider = Provider<AddPatientUseCase>((ref) {
  return AddPatientUseCase(ref.read(patientRepositoryProvider));
});

final deletePatientUseCaseProvider = Provider<DeletePatientUseCase>((ref) {
  return DeletePatientUseCase(ref.read(patientRepositoryProvider));
});

final patientsViewModelProvider = StateNotifierProvider<PatientViewModel, List<Patient>>((ref) {
  return PatientViewModel(
    ref.read(getAllPatientsUseCaseProvider), 
    ref.read(addPatientUseCaseProvider),
    ref.read(deletePatientUseCaseProvider)
    );
});