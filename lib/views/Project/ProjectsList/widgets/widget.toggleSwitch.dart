import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/LocalController/controller.theme.dart';
import '../../../../controllers/projectControllers/controller.projectList.dart';
import '../components/component.toggleContainerModel.dart';

Widget toggleSwitch() {
  final controller = Get.find<ProjectListController>();
  return Container(
    padding: EdgeInsets.all(8.sp),
    margin: EdgeInsets.symmetric(horizontal: 4.w),
    height: 53.sp,
    decoration: BoxDecoration(
        color: ThemeController.backgroundColor(),
        borderRadius: BorderRadius.circular(10.sp)),
    child: Row(
      children: [
        toggleSwitchContainerModel("Define", 0),
        toggleSwitchContainerModel('Progress', 1),
        toggleSwitchContainerModel('Next', 3),
        toggleSwitchContainerModel("Finis", 2)
      ],
    ),
  );
}
