import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.local.dart';
import 'package:khidma_artisan_flutter/views/Auth/widget.phoneNumber.dart';
import 'package:khidma_artisan_flutter/views/Wrapper/widget.wrapper.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constWidgets/behavior.dart';
import 'controllers/LocalController/controller.theme.dart';
import 'data/translation.data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: Transition.cupertino,
        theme: ThemeController.lightTheme,
        darkTheme: ThemeController.darkTheme,
        themeMode: ThemeController.getThemeMode(),
        debugShowMaterialGrid: false,
        locale: LocalController.currentLang(),
        translations: LocalString(),
        debugShowCheckedModeBanner: false,
        title: 'Khidma',
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child ?? Container(),
          );
        },
        home: const LogInWidget(),
      );
    });
  }
}

