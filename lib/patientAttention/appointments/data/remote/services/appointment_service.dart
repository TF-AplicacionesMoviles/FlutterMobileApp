import 'package:dentify_flutter/iam/data/storage/token_storage.dart';
import 'package:dentify_flutter/patientAttention/appointments/data/model/appointment_response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentService {
  final String baseUrl;

  AppointmentService(this.baseUrl);

  Future<List<AppointmentResponse>> getAllAppointments() async {
    final token = await TokenStorage.getAccessToken();

    final response = await http.get(Uri.parse('$baseUrl/v1/appointments'),
    headers: {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      }
    );

    
    if (response.statusCode == 200) {
      print("BODY: ${response.body}");
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((appointment) => AppointmentResponse.fromJson(appointment))
          .toList();
    } else {
      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");
      throw Exception('Failed to load appointments');
    }
  }
}