import 'package:dentify_flutter/core/network/api_constants.dart';
import 'package:dentify_flutter/navigation/dentify_app.dart';
import 'package:dentify_flutter/patientAttention/appointments/data/remote/services/appointment_service.dart';
import 'package:dentify_flutter/patientAttention/appointments/data/repository/appointment_repository_impl.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/repositories/appointment_repository.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/usecases/get_all_appointments_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AppointmentsModule {
  static AppointmentService provideAppointmentService() {
    return AppointmentService(ApiConstants.baseUrl); // Replace with your actual base URL
  }

  static AppointmentRepository provideAppointmentRepository() {
    return AppointmentRepositoryImpl(provideAppointmentService());
  }

  static GetAllAppointmentsUseCase provideGetAllAppointmentsUseCase() {
    return GetAllAppointmentsUseCase(provideAppointmentRepository());
  }

  static Widget provideAppointmentModule(){
    return MultiProvider(
      providers: [
        Provider<AppointmentService>(create: (_) => provideAppointmentService()),
        Provider<AppointmentRepository>(create: (_) => provideAppointmentRepository()),
        Provider<GetAllAppointmentsUseCase>(create: (_) => provideGetAllAppointmentsUseCase()),
      ],
      child: const DentifyApp(),
    );
  }
}