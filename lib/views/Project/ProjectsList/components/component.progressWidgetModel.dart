import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.projectList.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/models/model.project.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import '../../../../constWidgets/cashedNetwork.dart';
import '../../../../constWidgets/decoration.dart';
import '../../../../controllers/Local/controller.theme.dart';
import '../../../../data/fonc.data.dart';

Widget progressWidgetModel(int index) {
  final controller = Get.find<ProjectListController>();
  ProjectModel project = controller.projectByIndex(index);
  return InkWell(
    onTap: () {
      controller.toProgress(index, project);
    },
    child: Container(
      decoration: defaultDecoration(4, ThemeController.backgroundColor(), true),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.sp),
            child: ListTile(
              leading: SizedBox(
                height: 40.sp,
                width: 40.sp,
                child: ClipOval(child: cachedNetworkModel(project.post.urlPic)),
              ),
              title:
                  Text(project.post.title, style: TextStyle(fontSize: 12.sp)),
              subtitle: Text(
                project.currentStep.title +
                    " : " +
                    dateToStringListWithoutYear(project.currentStep.endDate),
                style: TextStyle(
                    color: ThemeController.secondaryColor(), fontSize: 10.sp),
              ),
            ),
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            animation: true,
            lineHeight: 3.sp,
            animationDuration: 500,
            percent: controller.percentProgress(project),
            barRadius: Radius.circular(30.sp),
            backgroundColor: ThemeController.backgroundColor(),
            progressColor:
                project.late ? Colors.red : ThemeController.greenSecondColor(),
          ),
        ],
      ),
    ),
  );
}
