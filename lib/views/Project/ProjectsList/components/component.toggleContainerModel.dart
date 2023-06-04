import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/projectControllers/controller.projectList.dart';
import 'package:khidma_artisan_flutter/data/font.data.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/LocalController/controller.theme.dart';

Widget toggleSwitchContainerModel(String title, int whichOne) {
  final controller = Get.find<ProjectListController>();
  return Obx(() {
    bool selected = controller.selected.value == whichOne;
    return Expanded(
      child: InkWell(
        onTap: () => {controller.updateSelected(whichOne)},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
              color: selected
                  ? ThemeController.primaryColor()
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.sp)),
          child: Center(
              child: FittedBox(
            child: Text(
              title,
              style: TextStyle(
                  color: selected
                      ? Colors.black
                      : ThemeController.secondaryColor(),
                  fontWeight: semiBold),
            ),
          )),
        ),
      ),
    );
  });
}
