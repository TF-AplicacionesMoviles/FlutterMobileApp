import 'package:dentify_flutter/patientAttention/appointments/data/remote/dto/add_appointment_request.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/model/patient_data_form.dart';
import 'package:dentify_flutter/patientAttention/appointments/presentation/di/presentation_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String formatDurationFromMinutes(String minutesString) {
  final totalMinutes = int.tryParse(minutesString) ?? 0;
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}


class AddAppointmentForm extends ConsumerStatefulWidget {
  const AddAppointmentForm({super.key});

  @override
  ConsumerState<AddAppointmentForm> createState() => _AddAppointmentFormState();
}

class _AddAppointmentFormState extends ConsumerState<AddAppointmentForm> {
  final _formKey = GlobalKey<FormState>();

  String reason = "";
  String duration = "";
  DateTime? selectedDate;
  int? selectedPatientId;

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(patientsDataFormProvider);

    return AlertDialog(
      title: const Text("New Appointment"),
      content: patientsAsync.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, _) => Text("Error loading patients: $err"),
        data: (patients) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: "Select patient",
                    ),
                    value: selectedPatientId,
                    items:
                        patients.map((PatientDataForm patient) {
                          return DropdownMenuItem<int>(
                            value: patient.id,
                            child: Text(
                              "${patient.firstName} ${patient.lastName}",
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPatientId = value;
                      });
                    },
                    validator: (v) => v == null ? "required" : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Reason"),
                    onChanged: (value) => reason = value,
                    validator:
                        (v) => v == null || v.isEmpty ? "required" : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Duration (minutes)",
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => duration = value,
                    validator: (v) {
                      if (v == null || v.isEmpty) return "required";
                      if (int.tryParse(v) == null) return "only numbers";
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedDate != null
                              ? "Selected: ${selectedDate!.toLocal().toString().split(' ')[0]}"
                              : "Select date",
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && selectedDate != null) {
              // date con hora 00:00:00 y con .000Z
              final appointmentDate =
                  DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    0, // hora 0
                    0, // minuto 0
                    0, // segundo 0
                    0, // milisegundos
                  ).toUtc().toIso8601String();

              final req = AddAppointmentRequest(
                appointmentDate: appointmentDate,
                reason: reason,
                duration: formatDurationFromMinutes(duration),
                patientId: selectedPatientId!,
              );
              Navigator.pop(context, req);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
