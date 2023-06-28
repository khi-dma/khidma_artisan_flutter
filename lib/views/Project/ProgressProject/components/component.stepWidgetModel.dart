import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khidma_artisan_flutter/controllers/Local/controller.theme.dart';
import 'package:khidma_artisan_flutter/controllers/project/controller.ProgressProject.dart';
import 'package:khidma_artisan_flutter/models/model.step.dart';
import 'package:sizer/sizer.dart';
import '../../../../data/fonc.data.dart';

Widget stepProgressProjectWidgetModel(int index) {
  final controller = Get.find<ProgressProjectController>();
  StepModel step = controller.project.steps[index];
  return Row(
    children: [
      Expanded(
        child: Opacity(
          opacity: step.checked ? 0.5 : 1,
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.sp),
                side: BorderSide(
                    color: step.checked
                        ? step.late
                            ? Colors.red
                            : ThemeController.greenSecondColor()
                        : ThemeController.tertiaryColor(),
                    width: 1.sp)),
            child: ListTile(
              title: Text(
                step.title,
                style: TextStyle(fontSize: 13.sp),
              ),
              subtitle: Text(
                  "Ends in " + dateToStringListWithoutYear(step.endDate),
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: ThemeController.secondaryColor())),
              trailing: Text(step.price.toString() + " " + "DA"),
            ),
          ),
        ),
      ),
      Visibility(
          visible: !(step.checked),
          child: GetBuilder(
              init: controller,
              id: "checkSteps",
              builder: (context) {
                return Checkbox(
                    activeColor: ThemeController.primaryColor(),
                    value: step.checkDemand,
                    onChanged: (newValue) =>
                        controller.updateChecked(newValue, step));
              }))
    ],
  );
}
