import 'package:flutter/material.dart';
import '../../domain/model/appointment_data_form.dart';
import '../../domain/usecases/add_invoice_use_case.dart';
import '../../domain/usecases/get_all_invoices_use_case.dart';
import '../../data/remote/dto/add_invoice_request.dart';

class InvoiceFormViewModel extends ChangeNotifier {
  final AddInvoiceUseCase addInvoiceUseCase;
  final GetAllAppointmentsFormInfoUseCase getAllAppointmentsFormInfoUseCase;

  List<AppointmentDataForm> appointments = [];

  InvoiceFormViewModel(this.addInvoiceUseCase, this.getAllAppointmentsFormInfoUseCase);

  Future<void> addInvoice(AddInvoiceRequest invoice) async {
    try {
      await addInvoiceUseCase.call(invoice);
      print("Factura enviada correctamente.");
    } catch (e) {
      print("Error al enviar la factura: ${e.toString()}");
    }
  }

  Future<void> loadAppointments() async {
    try {
      appointments = await getAllAppointmentsFormInfoUseCase.call();
      appointments = appointments.where((it) => !it.completed).toList();
      notifyListeners(); // Notificar a la UI que el estado ha cambiado
    } catch (e) {
      print("Error al cargar las citas: ${e.toString()}");
    }
  }
}
