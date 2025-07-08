import 'package:dentify_flutter/patientAttention/appointments/data/remote/dto/update_appointment_request.dart';
import 'package:dentify_flutter/patientAttention/appointments/domain/model/appointment.dart';
import 'package:flutter/material.dart';

String formatDurationFromMinutes(String minutesString) {
  final totalMinutes = int.tryParse(minutesString) ?? 0;
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}

class EditAppointmentForm extends StatefulWidget {
  final Appointment appointment;

  const EditAppointmentForm({super.key, required this.appointment});

  @override
  State<EditAppointmentForm> createState() => _EditAppointmentFormState();
}

class _EditAppointmentFormState extends State<EditAppointmentForm> {
  final _formKey = GlobalKey<FormState>();

  late String reason;
  late String duration;
  late String appointmentDate;

  @override
  void initState() {
    super.initState();
    reason = widget.appointment.reason;
    // Convertir HH:mm:ss a minutos totales
    final durationParts = widget.appointment.duration.split(":");
    final hours = int.tryParse(durationParts[0]) ?? 0;
    final minutes = int.tryParse(durationParts[1]) ?? 0;
    final totalMinutes = (hours * 60 + minutes).toString();

    duration = totalMinutes;
    appointmentDate = widget.appointment.appointmentDate;
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(appointmentDate) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        // hora 00:00
        appointmentDate = pickedDate.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Appointment"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: const Text("Pick date"),
            ),
            const SizedBox(height: 8),
            Text(
              appointmentDate.split("T").first,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              initialValue: reason,
              decoration: const InputDecoration(labelText: "Reason"),
              onChanged: (value) => reason = value,
              validator: (v) => v == null || v.isEmpty ? "required" : null,
            ),
            TextFormField(
              initialValue: duration,
              decoration: const InputDecoration(
                labelText: "Duration (minutes)",
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => duration = value,
              validator: (v) {
                final minutes = int.tryParse(v ?? '');
                if (minutes == null || minutes <= 0) {
                  return "Enter valid minutes";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final req = UpdateAppointmentRequest(
                appointmentDate: appointmentDate,
                reason: reason,
                duration: formatDurationFromMinutes(
                  duration,
                ), // convierte a HH:mm
              );
              Navigator.pop<Map<String, dynamic>>(context, {
                'id': widget.appointment.id,
                'update': req,
              });
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
