import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/resourses/widget/custom_elevated_buttom.dart';
import 'package:movie_app/core/routers.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          /*
         Text(UserModel.currentUser!.name),
         Text(UserModel.currentUser!.email),





       */
       CustomElevatedButton(
        text : "Logout",
        onPress: _logout,
      ),
    );

  }
  void _logout()async{
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context,AppRoutes.login);
  }
}

