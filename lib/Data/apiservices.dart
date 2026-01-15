// services/auth_service.dart
import 'package:dio/dio.dart';
import 'package:vlog/Utils/storage_service.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000', // Change to your base URL
      headers: {'Accept': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  AuthService() {
    // Add interceptor to automatically include token in headers
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get token from secure storage
          final token = await StorageService.getToken();
          final tokenType = await StorageService.getTokenType();

          // Add Authorization header if token exists
          if (token != null && token.isNotEmpty) {
            final authHeader = tokenType != null
                ? '$tokenType $token'
                : 'Bearer $token';
            options.headers['Authorization'] = authHeader;
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 unauthorized - token might be expired
          if (error.response?.statusCode == 401) {
            // Clear stored token on unauthorized
            await StorageService.clearAll();
          }
          return handler.next(error);
        },
      ),
    );
  }

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
        '/api/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        // Extract token and user data from response
        final accessToken = data['access_token'] as String?;
        final tokenType = data['token_type'] as String? ?? 'Bearer';
        final user = data['user'] as Map<String, dynamic>?;

        // Save token and user data to secure storage
        if (accessToken != null && accessToken.isNotEmpty) {
          await StorageService.saveToken(accessToken);
          await StorageService.saveTokenType(tokenType);

          if (user != null) {
            await StorageService.saveUser(user);
          }
        }

        return data; // { access_token, token_type, user }
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

  Future<String> logout() async {
    try {
      // Token will be automatically included via interceptor
      await _dio.post('/api/logout');

      // Clear stored token and user data after successful logout
      await StorageService.clearAll();

      return "Logged out successfully";
    } on DioException catch (e) {
      // Even if logout fails on server, clear local storage
      await StorageService.clearAll();
      print('Logout failed: ${e.response?.data}');
      rethrow;
    } catch (e) {
      // Even if logout fails, clear local storage
      await StorageService.clearAll();
      print('Unexpected error during logout: $e');
      rethrow;
    }
  }
}
