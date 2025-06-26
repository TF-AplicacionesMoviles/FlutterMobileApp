import 'package:json_annotation/json_annotation.dart';
import '../../domain/model/login.dart';

part 'register_response.g.dart';

class RegisterResponse {
  final String accessToken;
  final String refreshToken;
  final String username;

  RegisterResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.username,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'username': username,
    };
  }
}
