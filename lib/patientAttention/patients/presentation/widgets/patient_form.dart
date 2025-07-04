import 'package:dentify_flutter/patientAttention/patients/data/remote/dto/add_patient_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPatientForm extends ConsumerStatefulWidget {
  const AddPatientForm({super.key});

  @override
  ConsumerState<AddPatientForm> createState() => _AddPatientFormState();
}

class _AddPatientFormState extends ConsumerState<AddPatientForm> {
  final _formKey = GlobalKey<FormState>();

  String dni = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String homeAddress = "";
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Patient"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "DNI"),
                onChanged: (value) => dni = value,
                validator: (v) => v == null || v.isEmpty ? "required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "First name"),
                onChanged: (value) => firstName = value,
                validator: (v) => v == null || v.isEmpty ? "required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Last name"),
                onChanged: (value) => lastName = value,
                validator: (v) => v == null || v.isEmpty ? "required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (value) => email = value,
                validator: (v) => v == null || v.isEmpty ? "required" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Home Address"),
                onChanged: (value) => homeAddress = value,
                validator: (v) => v == null || v.isEmpty ? "required" : null,
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
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && selectedDate != null) {
              final birthday = "${selectedDate!.year.toString().padLeft(4, '0')}-"
                 "${selectedDate!.month.toString().padLeft(2, '0')}-"
                 "${selectedDate!.day.toString().padLeft(2, '0')}";

              final request = AddPatientRequest(
                dni: int.parse(dni),
                firstName: firstName,
                lastName: lastName,
                email: email,
                homeAddress: homeAddress,
                birthday: birthday,
              );

              print(birthday);
              Navigator.pop(context, request);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
