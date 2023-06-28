import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.projectList.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:sizer/sizer.dart';

import '../../../../constWidgets/cashedNetwork.dart';
import '../../../../constWidgets/decoration.dart';
import '../../../../controllers/Local/controller.theme.dart';

Widget finishedWidgetModel(int index){
  final controller = Get.find<ProjectListController>();
  ProjectModel project = controller.projectByIndex(index);
  return InkWell(
    onTap: () => controller.toFinish(index, project),
    child: Container(
      padding: EdgeInsets.all(5.sp),
      decoration: defaultDecoration(4, ThemeController.backgroundColor(), true),
      child: ListTile(
        leading: SizedBox(
          height: 40.sp,
          width: 40.sp,
          child: ClipOval(child: cachedNetworkModel(project.post.urlPic)),
        ),
        title: Text(project.title, style: TextStyle(fontSize: 12.sp)),
        subtitle: Text(
          "Project finished",
          style: TextStyle(
              color: ThemeController.secondaryColor(), fontSize: 10.sp),
        ),
      ),
    ),
  );
}