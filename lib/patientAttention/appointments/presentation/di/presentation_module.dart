import 'package:dentify_flutter/patientAttention/appointments/data/di/dependency_injection.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/model/appointment.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/usecases/get_all_appointments_use_case.dart';
import 'package:dentify_flutter/patientAttention/appointments/presentation/viewmodel/appointment_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllAppointmentsUseCaseProvider = Provider<GetAllAppointmentsUseCase>((ref) {
  return GetAllAppointmentsUseCase(ref.read(appointmentRepositoryProvider));

});

final appointmentsViewModelProvider = StateNotifierProvider<AppointmentViewModel, List<Appointment>>((ref) {
  return AppointmentViewModel(ref.read(getAllAppointmentsUseCaseProvider));
});