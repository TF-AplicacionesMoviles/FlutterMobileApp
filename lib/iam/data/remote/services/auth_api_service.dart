import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/login_request.dart';
import '../dto/register_request.dart';
import '../../model/login_response.dart';
import '../../model/register_response.dart';

class AuthApiService {
  final String baseUrl;

  AuthApiService(this.baseUrl);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(registerRequest.toJson()),
    );

    if (response.statusCode == 200) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}
