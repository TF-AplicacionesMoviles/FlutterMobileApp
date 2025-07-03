import 'package:flutter/material.dart';
import '../../presentation/view/invoice_view.dart';
import '../../presentation/view/add_invoice_form_view.dart';
import '../../presentation/di/presentation_module.dart';

Widget invoiceNavGraph() {
  final invoicesViewModel = PresentationModule.getInvoicesViewModel();
  final invoiceFormViewModel = PresentationModule.getInvoiceFormViewModel();

  final navigatorKey = GlobalKey<NavigatorState>();

  return Navigator(
    key: navigatorKey,
    initialRoute: '/payments',
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/payments':
          return MaterialPageRoute(
            builder: (context) => InvoiceView(
              viewModel: invoicesViewModel,
              toAddInvoiceForm: () {
                navigatorKey.currentState?.pushNamed('/add_invoice_form');
              },
            ),
          );
        case '/add_invoice_form':
          return MaterialPageRoute(
            builder: (context) => AddInvoiceFormView(
              viewModel: invoiceFormViewModel,
              toInvoices: () {
                navigatorKey.currentState?.pop();
              },
              toBack: () {
                navigatorKey.currentState?.pop();
              },
              onInvoicesSaved: () {
                invoicesViewModel.getAllInvoices();
              },
            ),
          );
        default:
          return MaterialPageRoute(
            builder: (context) => InvoiceView(
              viewModel: invoicesViewModel,
              toAddInvoiceForm: () {
                navigatorKey.currentState?.pushNamed('/add_invoice_form');
              },
            ),
          );
      }
    },
  );
}
