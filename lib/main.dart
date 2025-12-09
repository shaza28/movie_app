import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/resourses/router_manager.dart';
import 'package:movie_app/core/routers.dart';
import 'package:movie_app/feature/models/user_model.dart';
import 'package:movie_app/firebase/firebase_service.dart';
import 'config/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  try {
    if (FirebaseAuth.instance.currentUser != null) {
      print("User is logged in, fetching data...");
      UserModel.currentUser = await FirebaseServices.getUserFromFireStore(
          FirebaseAuth.instance.currentUser!.uid);

      if (UserModel.currentUser != null) {
        print(
            "User data loaded successfully: ${UserModel.currentUser!.toJson()}");
      } else {
        print("Warning: User data is null!");
      }
    } else {
      print("No user is currently logged in.");
    }
  } catch (e, stackTrace) {
    print("Error fetching user data: $e");
    print(stackTrace);
  }

  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        String initialRoute;
        if (FirebaseAuth.instance.currentUser != null &&
            UserModel.currentUser != null) {
          initialRoute = AppRoutes.homeScreen;
        } else {
          initialRoute = AppRoutes.register;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.router,
          initialRoute: AppRoutes.splashScreen,
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          locale: const Locale("en"),
          supportedLocales: const [Locale("en"), Locale("ar")],
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
