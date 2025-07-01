import 'package:dentify_flutter/patientAttention/appointments/domain/model/appointment.dart';

abstract class AppointmentRepository {
  Future<List<Appointment>> getAppointments();
}