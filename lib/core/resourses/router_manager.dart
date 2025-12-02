import 'package:flutter/material.dart';
import 'package:movie_app/core/routers.dart';

import 'package:movie_app/feature/authentication/register/login.dart';
import 'package:movie_app/feature/forget_password/forget_password.dart';
import 'package:movie_app/feature/on_boarding/on_boarding.dart';
import 'package:movie_app/feature/splash/splash_screen.dart';

import '../../feature/authentication/login/register.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => Register());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => Login());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPassword());

      default:
        return null;
    }
  }
}