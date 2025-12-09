import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/core/resourses/app_colors.dart';

class UIUtils{
  static void showLoading(BuildContext context,{bool isDismissible=true}){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context)=>PopScope(
          canPop:isDismissible ,
          child: AlertDialog(
              content:
              Column(
                mainAxisSize:MainAxisSize.min,
                children: [
          Center(child:CircularProgressIndicator(),),
                ],
              )),
        ));
  }
  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }
  static showMessage(BuildContext context, String message){
    showDialog(context: context,
        builder:(context)=>
      AlertDialog(content:Text(message,style:TextStyle(color:AppColors.black ) ,) ,)

    );
  }
 static void showToastMessage(String message,Color backgroundColor){
   Fluttertoast.showToast(
       msg: "Account Already Created",
       gravity: ToastGravity.BOTTOM,
       backgroundColor: backgroundColor,
       textColor: Colors.white,
       fontSize: 16.0
   );
 }
}