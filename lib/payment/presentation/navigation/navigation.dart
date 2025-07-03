import 'package:flutter/material.dart';
import '../../presentation/view/invoice_view.dart';
import '../../presentation/view/add_invoice_form_view.dart';
import '../../presentation/di/presentation_module.dart';

void invoiceNavGraph(BuildContext context) {
  final invoicesViewModel = PresentationModule.getInvoicesViewModel();
  final invoiceFormViewModel = PresentationModule.getInvoiceFormViewModel();

  final navigatorKey = GlobalKey<NavigatorState>();

  Navigator(
    key: navigatorKey,
    onGenerateRoute: (RouteSettings settings) {
      switch (settings.name) {
        case '/payments':
          return MaterialPageRoute(
            builder: (context) => InvoiceView(
              invoicesViewModel: invoicesViewModel,
              toAddInvoiceForm: () {
                navigatorKey.currentState?.pushNamed('/add_invoice_form');
              },
            ),
          );
        case '/add_invoice_form':
          return MaterialPageRoute(
            builder: (context) => AddInvoiceFormView(
              invoiceFormViewModel: invoiceFormViewModel,
              toInvoices: () {
                navigatorKey.currentState?.pop();
              },
              onInvoicesSaved: () {
                invoicesViewModel.getAllInvoices();
              },
            ),
          );
        default:
          return MaterialPageRoute(
            builder: (context) => InvoiceView(invoicesViewModel: invoicesViewModel),
          );
      }
    },
  );
}
