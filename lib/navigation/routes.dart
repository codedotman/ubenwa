import 'package:flutter/material.dart';
import 'package:ubenwa_cart/features/home/home_screen.dart';
import 'package:ubenwa_cart/features/onboarding/ub_login_screen.dart';
import 'package:ubenwa_cart/features/onboarding/ub_registration_screen.dart';
import 'package:ubenwa_cart/navigation/animation/fade_route.dart';
import 'package:ubenwa_cart/navigation/app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);

    switch (settings.name) {
      case AppRoutes.login:
        return FadeRoute(
          page: const UBLoginScreen(),
        );
      case AppRoutes.register:
        return FadeRoute(
          page: const UBRegistrationScreen(),
        );
      case AppRoutes.home:
        return FadeRoute(
          page: const HomeScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ERROR"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Page not found"),
        ),
      );
    });
  }
}
