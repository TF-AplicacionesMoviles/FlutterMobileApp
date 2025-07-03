import 'package:flutter/material.dart';
import '../../domain/model/invoice.dart';
import '../../presentation/viewmodel/invoice_view_model.dart';

class InvoiceView extends StatelessWidget {
  final InvoiceViewModel viewModel;
  final VoidCallback toAddInvoiceForm;

  InvoiceView({
    required this.viewModel,
    required this.toAddInvoiceForm,
  });

  @override
  Widget build(BuildContext context) {
    final invoices = viewModel.invoices;

    return Scaffold(
      appBar: AppBar(title: Text("Invoices")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            final invoice = invoices[index];
            return InvoiceItemView(invoice: invoice);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toAddInvoiceForm,
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF2C3E50),
      ),
    );
  }
}

class InvoiceItemView extends StatelessWidget {
  final Invoice invoice;

  InvoiceItemView({required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoice for ${invoice.patientName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('Appointment ID: ${invoice.appointmentId}'),
            Text('DNI: ${invoice.dni}'),
            Text('Email: ${invoice.email}'),
            Text('Amount: S/ ${invoice.amount}', style: TextStyle(color: Colors.green)),
            Text('Created at: ${invoice.createdAt.take(10)}', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
