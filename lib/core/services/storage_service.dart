
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _tokenKey = 'auth_token';
  // يمكن إضافة مفاتيح أخرى مثل user_id أو user_name

  // لحفظ مفتاح التوثيق بعد الدخول/التسجيل الناجح
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // لاسترجاع مفتاح التوثيق عند بدء التطبيق
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // لحذف مفتاح التوثيق عند تسجيل الخروج
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}