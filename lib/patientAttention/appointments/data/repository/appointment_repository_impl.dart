import 'package:dentify_flutter/patientAttention/appointments/domain/model/appointment.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/repositories/appointment_repository.dart';
import 'package:dentify_flutter/patientAttention/appointments/data/remote/services/appointment_service.dart';

class AppointmentRepositoryImpl implements AppointmentRepository{
  final AppointmentService appointmentService;

  AppointmentRepositoryImpl(this.appointmentService);

  @override
  Future<List<Appointment>> getAppointments() async {
    final appointmentResponses = await appointmentService.getAllAppointments();
    return appointmentResponses.map((response) => response.toDomain()).toList();
  }
}