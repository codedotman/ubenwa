import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:ubenwa_cart/navigation/navigation_service.dart';

class AppStartUp {
  Future<void> setUp() async {
    registerServices();
  }

  void registerServices() {
    GetIt.I.registerSingleton<NavigationService>(
        NavigationService()); // register Navigation Service
  }
}
