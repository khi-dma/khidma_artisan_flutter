import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/profileControllers/controller.portfolio.dart';
import 'package:sizer/sizer.dart';

import '../../Components/component.aboutInput.dart';

Widget about() {
  final controller = Get.find<PortfolioController>();
  return SizedBox(
    width: double.infinity,
    child: Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.sp)),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "About me :",
                  style: TextStyle(
                      fontSize: 13.sp, color: ThemeController.tertiaryColor()),
                ),
                const Spacer(),
                Visibility(
                  visible: !controller.edit.value,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    iconSize: 17.sp,
                    onPressed: () => controller.switchEdit(),
                    icon: Icon(
                      Icons.edit,
                      size: 17.sp,
                      color: ThemeController.tertiaryColor(),
                    ),
                  ),
                  replacement: Row(
                    children: [
                      IconButton(
                          onPressed: () =>controller.clear(),
                          icon: Icon(
                            Icons.clear,
                            size: 17.sp,
                            color: ThemeController.tertiaryColor(),
                          )),
                      IconButton(
                        onPressed: () =>controller.save(),
                        icon: Icon(
                          Icons.check,
                          size: 17.sp,
                          color: ThemeController.tertiaryColor(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 0.2.h),
            Obx(() => InputAboutComponent(
                  textEditingController: controller.aboutController,
                  maxLines: 7,
                  readOnly: controller.readOnly.value,
                )),
          ],
        ),
      ),
    ),
  );
}
