import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.ProgressProject.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/project/controller.preProject.dart';
import '../../../dialogbox/dialog.addStep.dart';
import '../components/component.stepWidgetModel.dart';

Widget stepsProgressProjectWidget() {
  final controller = Get.find<ProgressProjectController>();
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: controller.project.steps.length,
    itemBuilder: (context, index) => stepProgressProjectWidgetModel(index),
  );
}
