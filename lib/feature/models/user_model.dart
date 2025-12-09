
class UserModel {
  String? id;
  String? name;
  String? email;
  String? imageUrl;
  // 💡 حقل جديد: مفتاح التوثيق (Token)
  String? token;

  UserModel({this.id, this.name, this.email, this.imageUrl, this.token});

  // دالة تحويل البيانات من الخادم إلى نموذج (استخدمناها بدلاً من fromMap)
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      // 💡 نفترض أن الخادم يرسل المفاتيح بهذه الصيغة
      id: map['id'],
      name: map['name'],
      email: map['email'],
      imageUrl: map['image_url'], // تم تغيير key إلى image_url أو حسب ما يرسله الخادم
      token: map['token'],
    );
  }

  // دالة toJson لحفظ بيانات المستخدم محلياً أو إرسالها (إذا لزم الأمر)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image_url': imageUrl,
      'token': token,
    };
  }

  // إذا كنت تفضل استخدام fromMap، يمكنك الإبقاء عليها مع التأكد من أسماء المفاتيح
  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel.fromJson(map);

  static UserModel? currentUser;
}
/*

class UserModel {
  String? id;
  String? name;
  String? email;

  String? imageUrl;

  UserModel({this.id, this.name, this.email, this.imageUrl});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  static UserModel? currentUser;
}













//
// class UserModel {
//   String? id;
//   String? name;
//   String? email;
//
//   UserModel({this.id, this.name, this.email});
//
//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['id'],
//       name: map['name'],
//       email: map['email'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//     };
//   }
//
//   static UserModel? currentUser;
// }
*/
