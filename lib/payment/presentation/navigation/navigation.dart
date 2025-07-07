import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/view/invoice_view.dart';
import '../../presentation/view/add_invoice_form_view.dart';
import '../../presentation/di/presentation_module.dart';

Map<String, WidgetBuilder> paymentRoutes(WidgetRef ref) {
  // Aquí creamos las rutas para Payments
  final invoicesViewModel = PresentationModule.getInvoicesViewModel();
  final invoiceFormViewModel = PresentationModule.getInvoiceFormViewModel();

  return {
    '/payments': (context) => InvoiceView(
      viewModel: invoicesViewModel,
      toAddInvoiceForm: () {
        Navigator.pushNamed(context, '/add_invoice_form');
      },
    ),
    '/add_invoice_form': (context) => AddInvoiceFormView(
      viewModel: invoiceFormViewModel,
      toInvoices: () {
        Navigator.pushReplacementNamed(context, '/payments');  // Reemplaza la ruta
      },
      toBack: () {
        Navigator.pop(context);  // Regresa a la pantalla anterior
      },
      onInvoicesSaved: () {
        invoicesViewModel.getAllInvoices();
      },
    ),
  };
}
