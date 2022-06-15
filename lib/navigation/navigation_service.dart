import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> to({required String routeName}) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> toWithParameters({required String routeName, Object? args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  Future<dynamic> pushReplace({required String routeName, Object? args}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: args);
  }

  void newPage(Widget page) {
    Navigator.push(
      navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          body: page,
        ),
      ),
    );
  }

  void back() {
    return navigatorKey.currentState!.pop();
  }

  Future<dynamic> clearAllTo({required String routeName, Object? args}) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false, arguments: args);
  }
}
