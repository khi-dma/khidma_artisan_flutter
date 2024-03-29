import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/views/Profile/Portfolio/widget.portfolio.dart';
import 'package:khidma_artisan_flutter/views/Profile/available/widget.available.dart';
import 'package:khidma_artisan_flutter/views/Profile/diploma/widget.diploma.dart';
import 'package:khidma_artisan_flutter/views/Profile/savePost/widget.savePost.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/Local/controller.theme.dart';
import '../../controllers/profile/controller.profil.dart';
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
            listTileModel("savedPost".tr, "save", 14,
                () => Get.to(() => const SavedPostWidget())),
            const Divider(
              height: 0,
            ),
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
            listTileModel(
              "availability".tr,
              "available",
              14,
              () => Get.to(() => const AvailableWidget()),
            ),

            //Get.dialog(dialogBoxLang())),
          ],
        ),
      ),
    ],
  );
}
