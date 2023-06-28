import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/project/controller.preProject.dart';
import '../../../dialogbox/dialog.addStep.dart';
import '../components/component.stepWidgetModel.dart';

Widget stepsPreProjectWidget() {
  final controller = Get.find<PreProjectController>();
  return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    activeColor: ThemeController.greenSecondColor(),
                    contentPadding: EdgeInsets.zero,
                    value: controller.stepsEnabled,
                    onChanged: controller.updateStepEnabled,
                    title: const Text("Make the project as steps ?"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Visibility(
                  visible: controller.stepsEnabled,
                  child: IconButton(
                    onPressed: () => Get.dialog(dialogAddStep()),
                    icon: const Icon(Icons.add_rounded),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: controller.stepsEnabled,
              child: ReorderableListView.builder(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.project.steps.length,
                itemBuilder: (context, index) => stepPreProjectWidgetModel(index),
                onReorder: controller.onChangeOrder,
              ),
            ),
          ],
        );
}
