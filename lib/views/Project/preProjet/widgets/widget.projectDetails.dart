import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.preProject.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../../controllers/Local/controller.theme.dart';
import '../../../../data/fonc.data.dart';
import '../components/component.rowModel.dart';

Widget preProjectDetails() {
  final controller = Get.find<PreProjectController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Project Details',
            style: TextStyle(
                fontSize: 13.sp, color: ThemeController.secondaryColor()),
          ),
          Text(
            'Tap to update',
            style: TextStyle(
                fontSize: 11.sp, color: ThemeController.tertiaryColor()),
          ),
        ],
      ),
      SizedBox(height: 1.h),
      Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              rowModel("Title", controller.project.post.title, null),
              rowModel("Price", controller.project.price.toString() + " DA",
                  controller.stepsEnabled ? null : controller.updatePrice),
              rowModel(
                  "Starts in",
                  dateToStringPreProject(controller.project.startDate),
                  () => controller.updateDates(true)),
              rowModel(
                  "Ends in",
                  dateToStringPreProject(controller.project.endDate),
                  controller.stepsEnabled
                      ? null
                      : () => controller.updateDates(false)),
            ],
          ),
        ),
      )
    ],
  );
}
