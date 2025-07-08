import 'package:dentify_flutter/patientAttention/appointments/data/remote/dto/add_appointment_request.dart';
import 'package:dentify_flutter/patientAttention/appointments/data/remote/dto/update_appointment_request.dart';
import 'package:dentify_flutter/patientAttention/appointments/presentation/di/presentation_module.dart';
import 'package:dentify_flutter/patientAttention/appointments/presentation/widgets/add_appointment_form.dart';
import 'package:dentify_flutter/patientAttention/appointments/presentation/widgets/edit_appointment_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


String formatDateTime(String isoDateTime) {
  try {
    final dateTime = DateTime.parse(isoDateTime);
    return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
  } catch (e) {
    return isoDateTime; // fallback si algo falla
  }
}

String totalMinutes(String duration) {
  try {
    final parts = duration.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    final total = hours * 60 + minutes;
    return '$total min';
  } catch (e) {
    return duration; // fallback si algo falla
  }
}


class AppointmentsView extends ConsumerWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(appointmentsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        automaticallyImplyLeading: false,
      ),
      body:
          appointments.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD1F2EB),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.content_paste,
                                  color: Color(0xFF2C3E50),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appointment.patientName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'DNI: ${appointment.dni}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    'Appointment ID: ${appointment.id}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoRow(
                                  label: 'Date:',
                                  value: formatDateTime(
                                    appointment.appointmentDate,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                InfoRow(
                                  label: 'Reason:',
                                  value: appointment.reason,
                                ),
                                InfoRow(
                                  label: 'Completed:',
                                  value: appointment.completed.toString(),
                                ),
                                InfoRow(
                                  label: 'Duration:',
                                  value: totalMinutes(appointment.duration),
                                ),
                                InfoRow(
                                  label: 'Created:',
                                  value: formatDateTime(appointment.createdAt),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () async {
                                  final result =
                                      await showDialog<Map<String, dynamic>>(
                                        context: context,
                                        builder:
                                            (context) => EditAppointmentForm(
                                              appointment: appointment,
                                            ),
                                      );

                                  if (result != null) {
                                    final id = result['id'] as int;
                                    final update =
                                        result['update']
                                            as UpdateAppointmentRequest;

                                    print('Edit pressed');
                                    print('Updating appointment with ID: $id');
                                    print('With data: ${update.toJson()}');

                                    await ref
                                        .read(
                                          appointmentsViewModelProvider
                                              .notifier,
                                        )
                                        .updateAppointment(id, update);

                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Appointment updated"),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text('Edit'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder:
                                        (ctx) => AlertDialog(
                                          title: const Text("Confirm Delete"),
                                          content: const Text(
                                            "Are you sure you want to delete this appointment?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () =>
                                                      Navigator.pop(ctx, false),
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              onPressed:
                                                  () =>
                                                      Navigator.pop(ctx, true),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                  );

                                  if (confirm == true) {
                                    print('Delete pressed');
                                    print(
                                      'Deleting appointment with ID: ${appointment.id}',
                                    );
                                    await ref
                                        .read(
                                          appointmentsViewModelProvider
                                              .notifier,
                                        )
                                        .deleteAppointment(appointment.id);
                                    await ref
                                        .read(
                                          appointmentsViewModelProvider
                                              .notifier,
                                        )
                                        .getAllAppointments();

                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Appointment deleted"),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newAppointment = await showDialog<AddAppointmentRequest>(
            context: context,
            builder: (context) => const AddAppointmentForm(),
          );
          if (newAppointment != null) {
            await ref
                .read(appointmentsViewModelProvider.notifier)
                .addAppointment(newAppointment);
          }
        },
        backgroundColor: const Color.fromARGB(255, 117, 168, 219),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        icon: const Icon(Icons.add),
        //label: const Text('New Appointment (+)'),
      
        label: const Text(
          'New Appointment',
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Text(value),
        ],
      ),
    );
  }
}
