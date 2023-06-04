import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/constWidgets/cashedNetwork.dart';
import 'package:khidma_artisan_flutter/controllers/LocalController/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/projectControllers/controller.projectList.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:sizer/sizer.dart';

import '../../../../constWidgets/decoration.dart';
import '../../../../data/fonc.data.dart';

Widget nextWidgetModel(int index) {
  final controller = Get.find<ProjectListController>();
  ProjectModel project = controller.projectByIndex(index);
  return InkWell(
    child: Container(
      padding: EdgeInsets.all(5.sp),
      decoration: defaultDecoration(4, ThemeController.backgroundColor(), true),
      child: ListTile(
        leading: SizedBox(
          height: 40.sp,
          width: 40.sp,
          child: ClipOval(
              child: cachedNetworkModel(project.post.urlPic)),
        ),
        title: Text(project.title, style: TextStyle(fontSize: 12.sp)),
        subtitle: Text(
          "Starts in " + dateToStringListProject(project.startDate),
          style:
              TextStyle(color: ThemeController.secondaryColor(), fontSize: 10.sp),
        ),
      ),
    ),
  );
}
