import 'dart:convert';
import 'package:http/http.dart' as http;
import 'session_manager.dart';

class AuthService {
  static const String baseUrl = 'https://dummyjson.com';
  final SessionManager _sessionManager = SessionManager();

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        await _sessionManager.saveSession(
          token: data['token'],
          userData: data,
        );
        
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    return await _sessionManager.hasValidSession();
  }

  Future<Map<String, dynamic>?> getSavedUserData() async {
    return await _sessionManager.getUserData();
  }

  Future<void> logout() async {
    await _sessionManager.clearSession();
  }
}
