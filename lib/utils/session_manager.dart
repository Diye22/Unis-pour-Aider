import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static Future<void> saveUser(Map<String, dynamic> user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', user['uid'] ?? '');
    prefs.setString('user_nom', user['displayName'] ?? '');
    prefs.setString('user_email', user['email'] ?? '');
    prefs.setString('token', token);
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('user_id');
    final nom = prefs.getString('user_nom');
    final email = prefs.getString('user_email');
    final token = prefs.getString('token');

    if (uid != null && nom != null && email != null && token != null) {
      return {
        'uid': uid,
        'displayName': nom,
        'email': email,
        'token': token,
      };
    }
    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}