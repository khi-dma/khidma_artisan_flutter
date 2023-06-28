import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/profile/controller.diploma.dart';
import 'package:khidma_artisan_flutter/views/Components/component.button.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/Local/controller.theme.dart';

Widget uploadDiplomaWidget() {
  final controller = Get.find<DiplomaController>();
  return Center(
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        width: 90.w,
        decoration: BoxDecoration(
            color: ThemeController.backScaffoldGroundColor(),
            borderRadius: BorderRadius.circular(7.sp)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(7.sp),
                child: Image.file(File(controller.path.value))),
            SizedBox(
              height: 2.h,
            ),
            animatedButton("Upload", controller.upload, controller.btnController)
          ],
        )),
  );
}
