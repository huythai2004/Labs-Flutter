import 'dart:convert';
import 'package:http/http.dart' as http;
import 'session_manager.dart';
import '../../lab5_notification/services/notification_service.dart';

class AuthService {
  static const String baseUrl = 'https://dummyjson.com';
  final SessionManager _sessionManager = SessionManager();
  final NotificationService _notificationService = NotificationService();

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
        
        await _notificationService.showLoginSuccessNotification(
          username: data['username'] ?? username,
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
    await _notificationService.showLogoutNotification();
  }
}
