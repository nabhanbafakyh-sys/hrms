import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms_app/core/network/secure_storage.dart';
import 'package:hrms_app/model/login_request_model.dart';
import 'package:hrms_app/service/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _obscureText = true;
  bool get obscureText => _obscureText;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = LoginRequestModel(username: username, password: password);
      final response = await _authService.login(request: request);
      await SecureStorage.saveAccessToken(response.access);
      await SecureStorage.saveRefreshToken(response.refresh);

      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _errorMessage = "Invalid username or password";
      } else {
        _errorMessage = "Unable to login. Please try again.";
      }

      return false;
    } catch (e) {
      _errorMessage = "Something went wrong";

      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void togglePassword() {
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
