import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/LocalController/controller.theme.dart';
import '../../controllers/profileControllers/controller.profil.dart';

Widget dialogAvailability() {
  final controller = Get.find<ProfileController>();
  return Center(
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        width: 80.w,
        decoration: BoxDecoration(
            color: ThemeController.backScaffoldGroundColor(),
            borderRadius: BorderRadius.circular(7.sp)),
        child: Obx(
          () => Card(
            child: SwitchListTile(
              activeColor: Colors.green,
              title: const Text('Available'),
              value: controller.available.value,
              onChanged: controller.updateAvailability,
            ),
          ),
        )),
  );
}
