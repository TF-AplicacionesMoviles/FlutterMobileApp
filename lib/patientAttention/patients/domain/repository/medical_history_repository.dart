import 'package:dentify_flutter/patientAttention/patients/domain/model/medical_history.dart';

abstract class MedicalHistoryRepository {
  Future<List<MedicalHistory>> getMedicalHistories(int id);
}