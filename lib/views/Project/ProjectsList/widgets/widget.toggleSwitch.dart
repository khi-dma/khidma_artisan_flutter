import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/Local/controller.theme.dart';
import '../../../../controllers/project/controller.projectList.dart';
import '../components/component.toggleContainerModel.dart';

Widget toggleSwitch() {
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
        toggleSwitchContainerModel('Progress', 2),
        toggleSwitchContainerModel('Next', 1),
        toggleSwitchContainerModel("Finis", 3)
      ],
    ),
  );
}
