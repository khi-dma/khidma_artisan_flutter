import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/project/controller.finishedProject.dart';
import '../components/component.stepWidgetModel.dart';

Widget stepsFinishedProjectWidget() {
  final controller = Get.find<FinishedProjectController>();
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: controller.project.steps.length,
    itemBuilder: (context, index) => stepFinishedProjectWidgetModel(index),
  );
}
