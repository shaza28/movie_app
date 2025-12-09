
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../feature/models/register_request.dart';
import '../../feature/models/user_model.dart';
// يجب إضافة حزمة http في pubspec.yaml

class RestApiServices {

  // 📍📍📍 مكان رابط الـ API (URL) 📍📍📍
  // قم بتعديل هذا الرابط ليتطابق مع رابط خادمك
  static const String _baseUrl = "https://your-backend-api.com/api";

  // الـ Endpoints
  static const String _registerUrl = '$_baseUrl/register';
  static const String _loginUrl = '$_baseUrl/login';


  // -----------------------------------------------------
  // 1. دالة التسجيل (POST /register)
  // -----------------------------------------------------
  // لا تتوقع هنا إرجاع UserModel، بل فقط إشارة نجاح (Map<String, dynamic>)
  static Future<Map<String, dynamic>> register(RegisterRequest request) async {
    final url = Uri.parse(_registerUrl);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      String errorMessage = 'Registration failed. Status: ${response.statusCode}';
      try {
        final errorBody = jsonDecode(response.body);
        errorMessage = errorBody['message'] ?? errorMessage;
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }

  // -----------------------------------------------------
  // 2. دالة الدخول (POST /login)
  // -----------------------------------------------------
  // تتوقع إرجاع UserModel كامل (مع الـ Token)
  static Future<UserModel> login(String email, String password) async {
    final url = Uri.parse(_loginUrl);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // 💡 بناء نموذج المستخدم من البيانات المستلمة
      return UserModel.fromJson(data);

    } else {
      String errorMessage = 'Login failed. Status: ${response.statusCode}';
      try {
        final errorBody = jsonDecode(response.body);
        errorMessage = errorBody['message'] ?? errorMessage;
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }
}