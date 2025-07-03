import '../../domain/model/invoice.dart';

class InvoiceResponse {
  final int id;
  final int appointmentId;
  final String patientName;
  final String dni;
  final String email;
  final int amount;
  final String createdAt;

  InvoiceResponse({
    required this.id,
    required this.appointmentId,
    required this.patientName,
    required this.dni,
    required this.email,
    required this.amount,
    required this.createdAt,
  });

  // Convertir a dominio
  Invoice toDomain() {
    return Invoice(
      id: id,
      appointmentId: appointmentId,
      patientName: patientName,
      dni: dni,
      email: email,
      amount: amount,
      createdAt: createdAt,
    );
  }
}
