import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/Local/controller.theme.dart';
import '../../controllers/profile/controller.profil.dart';


Widget dialogBoxAppearance() {

  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      width: 70.w,
      decoration: BoxDecoration(
          color: ThemeController.backScaffoldGroundColor(), borderRadius: BorderRadius.circular(7.sp)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          cardThemeModel("light",ThemeMode.light,Icons.light_mode),
          cardThemeModel("dark",ThemeMode.dark,Icons.dark_mode),
          cardThemeModel("system",ThemeMode.system,Icons.phone_android_rounded),
        ],
      ),
    ),
  );
}

Card cardThemeModel(String title,ThemeMode theme,IconData icon) {
  final controller = Get.find<ProfileController>();
  return Card(
          color: controller.verifyMood(theme) ? ThemeController.backgroundColor(): ThemeController.backScaffoldGroundColor(),
          elevation: 0,
          child:  ListTile(
            onTap: ()=> controller.changeTheme(title,theme),
            title: Text(title),
            trailing: Icon(icon),
          ),
        );
}
