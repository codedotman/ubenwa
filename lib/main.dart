import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ubenwa_cart/configs/app_startup.dart';
import 'package:ubenwa_cart/data/controllers/home_controller.dart';
import 'package:ubenwa_cart/data/controllers/infant_upload_controller.dart';
import 'package:ubenwa_cart/data/controllers/login_controller.dart';
import 'package:ubenwa_cart/data/controllers/registration_controller.dart';
import 'package:ubenwa_cart/data/local/local_storage.dart';
import 'package:ubenwa_cart/data/local/storage_keys.dart';
import 'package:ubenwa_cart/navigation/navigation_service.dart';
import 'package:ubenwa_cart/navigation/routes.dart';
import 'package:ubenwa_cart/utils/constants.dart';
import 'package:ubenwa_cart/utils/strings.dart';

import 'navigation/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppStartUp().setUp();
  initializeService();
  runApp(const MyApp());
}

void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1200), (timer) async {
    bool runServiceUpload =
        await LocalStorage.readBool(StorageKeys.runServiceUpload) ?? false;

    if (runServiceUpload) {
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Ubenwa Infant Upload",
          content: "Last Updated at ${DateTime.now()}",
        );
      }

      final deviceInfo = DeviceInfoPlugin();
      String? device;
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        device = androidInfo.model;
      }

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        device = iosInfo.model;
      }

      InfantUploadController().uploadInfantDetails();

      service.invoke(
        'update',
        {
          "current_date": DateTime.now().toIso8601String(),
          "device": device,
        },
      );
    }
  });
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, Widget? child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => LoginController()),
              ChangeNotifierProvider(create: (_) => RegistrationController()),
              ChangeNotifierProvider(create: (_) => HomeController()),
            ],
            child: MaterialApp(
              title: kAppName,
              debugShowCheckedModeBanner: false,
              theme: kThemeData,
              themeMode: ThemeMode.light,
              initialRoute: AppRoutes.login,
              navigatorKey: GetIt.I.get<NavigationService>().navigatorKey,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          ),
        );
      },
    );
  }
}
