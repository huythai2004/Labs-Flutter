class MockAuthService {
  static const String _mockEmail = 'demo@example.com';
  static const String _mockPassword = 'password123';
  static const String _mockToken = 'mock_token_abc123xyz789def456ghi';

  Future<String?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == _mockEmail && password == _mockPassword) {
      return _mockToken;
    }

    return null;
  }

  Future<bool> validateToken(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return token == _mockToken;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
