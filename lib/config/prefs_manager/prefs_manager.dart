/*
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;
  static Future<void> init()async{
   prefs=await SharedPreferences.getInstance();
}
  static void savedLanguage(String language){
    prefs.setString(CacheConstant.languageKey,language);
  }
static String? getSavedLanguage(){
    String?savedLanguage=prefs.getString(CacheConstant.languageKey);
   return savedLanguage;
  }




}
*/
