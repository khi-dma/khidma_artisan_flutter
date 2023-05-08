import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController {
  static ThemeData darkTheme = ThemeData(
    inputDecorationTheme: InputDecorationTheme(fillColor:Color(0XFF24252a) ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0XFF24252a),
    ),
    cardTheme: const CardTheme(elevation: 0),
    cardColor: const Color(0XFF24252a),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0XFF121212),
        titleTextStyle: TextStyle(color: Colors.white)),
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
    scaffoldBackgroundColor: const Color(0XFF121212),
    brightness: Brightness.dark,
    primaryColor: const Color(0xffEFC74F),
    colorScheme: const ColorScheme(
        background: Color(0XFF24252a),
        brightness: Brightness.dark,
        primary: Color(0xffEFC74F),
        onPrimary: Color(0xffEFC74F),
        secondary: Color(0XFFA4ABB0),
        onSecondary: Color(0XFFA4ABB0),
        tertiary: Color(0xff797e84),
        error:  Colors.redAccent,
        onError:Colors.redAccent,
        onBackground: Color(0xff797e84),
        surface: Color(0xff797e84),
        onSurface: Colors.white),
  );

  static ThemeData lightTheme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(fillColor: Colors.white ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.lightBlue,
    ),
    cardColor: Colors.white,
    cardTheme: const CardTheme(elevation: 0),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        backgroundColor:  Color(0XFFF7F7F7),
        titleTextStyle: TextStyle(color: Colors.black)),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.black),
    scaffoldBackgroundColor: const Color(0XFFF7F7F7),
    brightness: Brightness.light,
    primaryColor: const Color(0xffCBA029),
    colorScheme: ColorScheme(
        background: Colors.white,
        brightness: Brightness.light,
        primary: const Color(0xffCBA029),
        onPrimary: const Color(0xffCBA029),
        secondary: const Color(0xff707070).withOpacity(0.4),
        onSecondary: const Color(0XFF707070),
        tertiary: const Color(0xff707070),
        error:  Colors.redAccent,
        onError:Colors.redAccent,
        onBackground: const Color(0xff2D6D3B),
        surface: const Color(0xff2D6D3B),
        onSurface: const Color(0xff2D6D3B)),
  );

  static final box = GetStorage();

  static ThemeMode getThemeMode() {
    var theme = box.read("theme") ?? "system";
    switch (theme) {
      case "system":
        return ThemeMode.system;
      case "light":
        return ThemeMode.light;
      default:
        return ThemeMode.dark;
    }
  }

  static setTheme(String newTheme, ThemeMode theme) {
    Get.changeThemeMode(theme);
    box.write("theme", newTheme);
  }

  static bool isThemeDark() {
    return box.read("theme") == "dark";
  }

  static Color primaryColor() => Theme.of(Get.context!).colorScheme.primary;

  static Color secondaryColor() => Theme.of(Get.context!).colorScheme.secondary;

  static Color tertiaryColor() => Theme.of(Get.context!).colorScheme.tertiary;

  static Color backgroundColor() =>
      Theme.of(Get.context!).colorScheme.background;

  static Color backScaffoldGroundColor() =>
      Theme.of(Get.context!).scaffoldBackgroundColor;

  static Color oppositeColor() => isThemeDark() ? Colors.white : Colors.black;
}
