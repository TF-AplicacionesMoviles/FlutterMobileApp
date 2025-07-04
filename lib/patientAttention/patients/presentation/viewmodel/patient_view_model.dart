import 'package:dentify_flutter/patientAttention/patients/data/remote/dto/add_patient_request.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/model/patient.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/add_patient_use_case.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/delete_patient_use_case.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/get_all_patients_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientViewModel extends StateNotifier<List<Patient>> {
  final GetAllPatientsUseCase getAllPatientsUseCase;
  final AddPatientUseCase addPatientUseCase;
  final DeletePatientUseCase deletePatientUseCase;
  String? errorMessage;

  PatientViewModel(
    this.getAllPatientsUseCase, 
    this.addPatientUseCase,
    this.deletePatientUseCase) : super([]) {
    getAllPatients();
  }

  Future<void> getAllPatients() async {
    try {
      final patients = await getAllPatientsUseCase();
      state = patients;
    } catch (e) {
      errorMessage = e.toString();
      state = []; 
      print('Error fetching patients: $errorMessage');
    }
  }

  Future<void> addPatient(AddPatientRequest newPatient) async {
    // Llamar usecase correspondiente
    try {
      await addPatientUseCase(newPatient);
      await getAllPatients(); // recargar
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> deletePatient(int id) async {
    try {
      await deletePatientUseCase(id);
      await getAllPatients();
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}