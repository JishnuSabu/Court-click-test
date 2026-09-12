import 'package:flutter/material.dart';
import '../../screens/splash_screen.dart';
import '../../screens/profile_selection_screen.dart';
import '../../screens/main_nav_screen.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.profileSelection:
        return MaterialPageRoute(builder: (_) => const ProfileSelectionScreen());
      case RouteNames.mainNav:
        return MaterialPageRoute(builder: (_) => const MainNavScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
