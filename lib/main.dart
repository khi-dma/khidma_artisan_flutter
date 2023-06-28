import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.local.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.phoneNumber.dart';
import 'package:khidma_artisan_flutter/views/Wrapper/widget.wrapper.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constWidgets/behavior.dart';
import 'controllers/Local/controller.theme.dart';
import 'controllers/Notifications/controller.management.dart';
import 'data/translation.data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  requestPermission();
  await GetStorage.init();
  runApp(const MyApp());}

requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ManagementNotificationController());
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        locale: LocalController.getLang() == "fr" ?  const Locale('fr', 'FR') : const Locale('en', 'EN') ,
        defaultTransition: Transition.cupertino,
        theme: ThemeController.lightTheme,
        darkTheme: ThemeController.darkTheme,
        themeMode: ThemeController.getThemeMode(),
        debugShowMaterialGrid: false,
        translations: LocalString(),
        debugShowCheckedModeBanner: false,
        title: 'Khidma',
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child ?? Container(),
          );
        },
        home: const WrapperWidget(),
      );
    });
  }
}

