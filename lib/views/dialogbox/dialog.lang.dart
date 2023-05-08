import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/LocalController/controller.theme.dart';
import '../../controllers/profileControllers/controller.profilController.dart';


Widget dialogBoxLang() {

  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      width: 70.w,
      decoration: BoxDecoration(
          color: ThemeController.backScaffoldGroundColor(), borderRadius: BorderRadius.circular(7.sp)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          cardLangModel("English","en",const Locale('en', 'US')),
          cardLangModel("French","fr",const Locale('fr', 'FR')),
          cardLangModel("Arabic","ar",const Locale('ar')),
        ],
      ),
    ),
  );
}

Card cardLangModel(String title,String lang,Locale locale) {
  final controller = Get.find<ProfileController>();
  return Card(
    color: controller.verifyLang(lang) ? ThemeController.backgroundColor(): ThemeController.backScaffoldGroundColor(),
    elevation: 0,
    child:  ListTile(
      onTap: ()=> controller.changeLang(lang,locale),
      title: Text(title),
      trailing:controller.verifyLang(lang) ?  const Icon(Icons.check):null,
    ),
  );
}
