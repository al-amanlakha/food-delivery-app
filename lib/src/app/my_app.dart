import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_strings.dart';
import '../injector.dart';
import '../routes/app_routes.dart';
import '../screens/splash/splash_view.dart';
import '../utils/global_logger.dart';
import '../utils/global_utils.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalLogger _globalLogger = GlobalLogger();

  AppLifecycleState? _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _globalLogger.logger.i("App in Resumed State");
        break;
      case AppLifecycleState.inactive:
        _globalLogger.logger.i("App in Inactive State");
        break;
      case AppLifecycleState.paused:
        _globalLogger.logger.i("App in Paused State");
        break;
      case AppLifecycleState.detached:
        _globalLogger.logger.i("App in Detached State");
        break;
      case AppLifecycleState.hidden:
        _globalLogger.logger.i("App in Hidden State");
    }
    setState(() {
      _notification = state;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        getPages: AppRoutes.instance.pages,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        initialRoute: SplashView.id,
        title: AppStrings.appTitle,
        navigatorKey: navigatorKey,
        initialBinding: Injector(),
      ),
    );
  }
}
