import 'package:dentify_flutter/patientAttention/appointments/domain/model/appointment.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/usecases/get_all_appointments_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppointmentViewModel extends StateNotifier<List<Appointment>> {
  final GetAllAppointmentsUseCase getAllAppointmentsUseCase;
  String? errorMessage;

  AppointmentViewModel(this.getAllAppointmentsUseCase) : super([]){
    getAllAppointments();
  }

  Future<void> getAllAppointments() async {
    try {
      final appointments = await getAllAppointmentsUseCase();
      state = appointments;
      
    } catch (e) {
      errorMessage = e.toString();
      state = []; // Reset state on error
      print('Error fetching appointments: $errorMessage');
    }
  }
}