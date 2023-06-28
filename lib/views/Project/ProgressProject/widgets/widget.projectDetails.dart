import 'package:flutter/material.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.ProgressProject.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.preProject.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../../controllers/Local/controller.theme.dart';
import '../../../../data/fonc.data.dart';
import '../../preProjet/components/component.rowModel.dart';

Widget progressProjectDetails() {
  final controller = Get.find<ProgressProjectController>();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Project Details',
        style: TextStyle(
            fontSize: 13.sp, color: ThemeController.secondaryColor()),
      ),

      SizedBox(height: 1.h),
      Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              rowModel("Title", controller.project.post.title, null),
              rowModel(
                  "Price", controller.project.price.toString() + " DA", null),
              rowModel("Starts in", dateToStringPreProject(controller.project.startDate), null),
              rowModel("Ends in",dateToStringPreProject(controller.project.endDate), null),
            ],
          ),
        ),
      )
    ],
  );
}
