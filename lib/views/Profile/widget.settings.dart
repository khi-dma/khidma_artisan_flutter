import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/views/dialogbox/dialog.lang.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../controllers/Local/controller.theme.dart';
import '../dialogbox/dialog.theme.dart';
import 'component/component.rowModel.dart';

Widget settings() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Settings',
        style:
        TextStyle(color: ThemeController.tertiaryColor(), fontSize: 12.sp),
      ),
      SizedBox(
        height: 1.h,
      ),
      Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.sp)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            listTileModel("appearance".tr, "appearance", 14, () =>
                Get.dialog(dialogBoxAppearance())
            ),
            const Divider(
              height: 0,
            ),
            listTileModel("language".tr, "lang", 14,  () =>
                Get.dialog(dialogBoxLang())),
          ],
        ),
      ),
    ],
  );
}
