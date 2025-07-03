import 'package:flutter/material.dart';
import '../../domain/model/appointment_data_form.dart';
import '../../data/remote/dto/add_invoice_request.dart';
import '../../presentation/viewmodel/invoice_form_view_model.dart';

class AddInvoiceFormView extends StatelessWidget {
  final InvoiceFormViewModel viewModel;
  final VoidCallback toInvoices;
  final VoidCallback toBack;
  final VoidCallback onInvoicesSaved;

  AddInvoiceFormView({
    required this.viewModel,
    required this.toInvoices,
    required this.toBack,
    required this.onInvoicesSaved,
  });

  @override
  Widget build(BuildContext context) {
    final amountController = TextEditingController();
    final appointmentId = ValueNotifier<int>(0);
    final paymentMethodId = ValueNotifier<int>(0);
    final showSuccessDialog = ValueNotifier<bool>(false);

    viewModel.loadAppointments();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Invoice'),
        backgroundColor: Color(0xFF2C3E50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Color(0xFFD1F2EB),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Add a new Invoice',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: amountController,
                          decoration: InputDecoration(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 8),
                        AppointmentDropdown(
                          appointments: viewModel.getAppointments().value,
                          selectedAppointmentId: appointmentId.value,
                          onAppointmentSelected: (id) {
                            appointmentId.value = id;
                          },
                        ),
                        SizedBox(height: 8),
                        Text('Payment Method'),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                paymentMethodId.value = 1;
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  paymentMethodId.value == 1
                                      ? Colors.teal
                                      : Colors.grey,
                                ),
                              ),
                              child: Text('Credit Card'),
                            ),
                            SizedBox(width: 4),
                            ElevatedButton(
                              onPressed: () {
                                paymentMethodId.value = 2;
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  paymentMethodId.value == 2
                                      ? Colors.teal
                                      : Colors.grey,
                                ),
                              ),
                              child: Text('Cash'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: toBack,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Go back to invoice general view',
                        style: TextStyle(
                          color: Color(0xFF2C3E50),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final invoice = AddInvoiceRequest(
                  amount: int.parse(amountController.text),
                  appointmentId: appointmentId.value,
                  paymentMethodId: paymentMethodId.value,
                );

                viewModel.addInvoice(invoice);
                showSuccessDialog.value = true;
                onInvoicesSaved();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF2C3E50)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                )),
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      // Success Dialog
      bottomSheet: ValueListenableBuilder<bool>(
        valueListenable: showSuccessDialog,
        builder: (context, showDialog, child) {
          if (showDialog) {
            return AlertDialog(
              title: Text("Invoice registered successfully!"),
              actions: [
                TextButton(
                  onPressed: () {
                    showSuccessDialog.value = false;
                    toInvoices();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

class AppointmentDropdown extends StatelessWidget {
  final String label;
  final List<AppointmentDataForm> appointments;
  final int selectedAppointmentId;
  final Function(int) onAppointmentSelected;

  AppointmentDropdown({
    required this.label,
    required this.appointments,
    required this.selectedAppointmentId,
    required this.onAppointmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              selectedAppointmentId != 0
                  ? 'ID: $selectedAppointmentId'
                  : 'Select an appointment',
            ),
          ),
        ),
      ],
    );
  }
}
