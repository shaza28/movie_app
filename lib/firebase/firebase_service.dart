import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/feature/models/login_request.dart';
import 'package:movie_app/feature/models/register_request.dart';
import 'package:movie_app/feature/models/user_model.dart';

class FirebaseServices {
  static Future<UserCredential> register(RegisterRequest request) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: request.email,
          password: request.password,
        );

    return userCredential;
  }

  static Future<UserCredential> login(LoginRequest request) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: request.email,
          password: request.password,
        );
    return userCredential;
  }

  static Future <void> addUserToFireStore(UserModel user) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> usersCollection = db.collection(
      "Users",
    );
    DocumentReference<Map<String, dynamic>> userDocument=usersCollection.doc();
     return userDocument.set({
      "id":user.id,
      "email":user.email,
      "name":user.name,

    });



  }

  static Future <UserModel> getUserFromFireStore(String uid)async{
    FirebaseFirestore db=FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> usersCollection= db.collection("Users");
      DocumentReference<Map<String, dynamic>> userDocument= usersCollection.doc(uid);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =await userDocument.get();
      var json= documentSnapshot.data();
      return UserModel(id: json?["id"], name:json?["name"], email:json?["email"]);

  }


}
