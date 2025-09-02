import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouters {
  static String get initialRoute => RoutesName.splashScreen;

  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("no route defined for ${settings.name} "),
            ),
          ),
        );
    }
  }
}
