import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
