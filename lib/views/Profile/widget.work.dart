import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.profilController.dart';
import 'package:khidma_artisan_flutter/views/Profile/Portfolio/widget.portfolio.dart';
import 'package:khidma_artisan_flutter/views/Profile/diploma/widget.diploma.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/LocalController/controller.theme.dart';
import 'component/component.rowModel.dart';

Widget workProfile() {
  final controller = Get.find<ProfileController>();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'work'.tr,
        style:
            TextStyle(color: ThemeController.tertiaryColor(), fontSize: 12.sp),
      ),
      SizedBox(
        height: 1.h,
      ),
      Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            listTileModel("portfolio".tr, "portf", 14,
                () => Get.to(() => const PortfolioWidget())),
            const Divider(
              height: 0,
            ),
            listTileModel("diploma".tr, "diploma", 15,
                () => Get.to(() => const DiplomaWidget())),
            const Divider(
              height: 0,
            ),
            Obx(
                ()=> listTileModel(
                  "availability".tr,
                  "availability",
                  9,
                  controller.showDialog,
                  controller.available.value ? Colors.green:Colors.red),
            )
            //Get.dialog(dialogBoxLang())),
          ],
        ),
      ),
    ],
  );
}
