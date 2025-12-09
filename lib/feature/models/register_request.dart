/*
class RegisterRequest{
String email;
String password;
RegisterRequest({required this.email,required this.password});

}*/
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String? imageUrl;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.imageUrl,
  });

  // 💡 هذه الدالة هي التي تُستخدم لتحويل البيانات إلى JSON لطلب الـ API
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'image_url': imageUrl,
    };
  }
}