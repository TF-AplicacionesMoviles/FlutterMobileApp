import 'package:dentify_flutter/core/network/api_constants.dart';
import 'package:dentify_flutter/navigation/dentify_app.dart';
import 'package:dentify_flutter/patientAttention/patients/data/remote/services/patient_service.dart';
import 'package:dentify_flutter/patientAttention/patients/data/repository/patient_repository_impl.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/repository/patient_repository.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/add_patient_use_case.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/delete_patient_use_case.dart';
import 'package:dentify_flutter/patientAttention/patients/domain/usecases/get_all_patients_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PatientsModule {
  static PatientService providePatientService() {
    return PatientService(ApiConstants.baseUrl);
  }

  static PatientRepository providePatientRepository() {
    return PatientRepositoryImpl(providePatientService());
  }

  static GetAllPatientsUseCase provideGetAllPatientsUseCase() {
    return GetAllPatientsUseCase(providePatientRepository());
  }

  static AddPatientUseCase provideAddPatientUseCase() {
    return AddPatientUseCase(providePatientRepository());
  }

  static DeletePatientUseCase provideDeletePatientUseCase() {
    return DeletePatientUseCase(providePatientRepository());
  }

  static Widget providePatientModule() {
    return MultiProvider(
      providers: [
        Provider<PatientService>(create: (_) => providePatientService()),
        Provider<PatientRepository>(create: (_) => providePatientRepository()),
        Provider<GetAllPatientsUseCase>(create: (_) => provideGetAllPatientsUseCase()),
        Provider<AddPatientUseCase>(create: (_) => provideAddPatientUseCase()),
        Provider<DeletePatientUseCase>(create: (_) => provideDeletePatientUseCase()),
      ],
      child: const DentifyApp(),
    );
  }
}