import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/features/auth/screens/login_screen.dart';
import 'package:dating_application/features/matching/screens/discover_screen.dart';
import 'package:dating_application/features/onboarding/screen/welcome_screen.dart';
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
      case RoutesName.welcome:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.discover:
        return MaterialPageRoute(
          builder: (context) => const DiscoverScreen(),
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
