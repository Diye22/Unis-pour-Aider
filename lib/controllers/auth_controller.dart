import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/session_manager.dart';

class AuthController with ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login(String email, String password, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AuthService.login(email: email, password: password);

      if (result['user'] != null) {
        await SessionManager.saveUser(result['user'], result['token']);
        _isLoading = false;
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/campagnes');
        return true;
      } else {
        _error = result['error'] ?? 'Erreur inconnue';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String nom, String email, String password, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await AuthService.register(nom: nom, email: email, password: password);

      if (result['message'] != null) {
        _isLoading = false;
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/login');
        return true;
      } else {
        _error = result['error'] ?? 'Erreur inconnue';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
