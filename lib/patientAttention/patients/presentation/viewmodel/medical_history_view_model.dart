import 'package:dentify_flutter/patientAttention/patients/domain/model/medical_history.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/get_all_medical_histories_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicalHistoryViewModel extends StateNotifier<List<MedicalHistory>>{
  final GetAllMedicalHistoriesUseCase getAllMedicalHistoriesUseCase;
  String? errorMessage;
  bool isLoading = true;

  MedicalHistoryViewModel(
    this.getAllMedicalHistoriesUseCase,
    int id
  ): super([]) {
    getAllMedicalHistories(id);
  }

  Future<void> getAllMedicalHistories(int id) async {
  try {
    isLoading = true;
    final medicalHistories = await getAllMedicalHistoriesUseCase(id);
    state = medicalHistories;
  } catch (e) {
    errorMessage = e.toString();
    state = [];
  } finally {
    isLoading = false;
  }
}
}