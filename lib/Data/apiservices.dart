// services/auth_service.dart
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fivekl-backend.onrender.com', // Change to your base URL
      headers: {'Accept': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  String get baseUrl => _dio.options.baseUrl;

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/register',
        data: {
          "username": name,
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "roles": [role],
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData = response.data['user'];
        print('Registration successful: $userData');
        return userData;
      }
    } on DioException catch (e) {
      print('Registration failed: ${e.response?.data}');
    } catch (e) {
      print('Unexpected error: $e');
    }
    return {};
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return data; // { token, user }
      }
    } on DioException catch (e) {
      print('Login failed: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Unexpected error during login: $e');
      rethrow;
    }
    return {};
  }

  /// Returns the provider initiation URL (e.g., GET /auth/google)
  String getOAuthInitiationUrl(String provider) {
    return '${_dio.options.baseUrl}/api/auth/$provider';
  }

  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    try {
      final response = await _dio.post(
        'api/auth/forgotpassword',
        data: {'email': email},
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
    } on DioException catch (e) {
      print('Forgot password failed: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Unexpected error during forgot password: $e');
      rethrow;
    }
    return {};
  }

  Future<Map<String, dynamic>> resetPassword({
    required String resetToken,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final response = await _dio.put(
        'api/auth/resetpassword/$resetToken',
        data: {'password': password, 'passwordConfirm': passwordConfirm},
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>; // expects token + user
      }
    } on DioException catch (e) {
      print('Reset password failed: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Unexpected error during reset password: $e');
      rethrow;
    }
    return {};
  }

  Future<String> logout({required String resetToken}) async {
    try {
      await _dio.post(
        'api/auth/logout',
        data: {'resetToken': resetToken},
      );
      return "Logged successfully";
    } catch (e) {
      print('Unexpected error during logout: $e');
      rethrow;
    }
  }
}
