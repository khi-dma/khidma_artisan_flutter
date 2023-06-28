import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../controllers/Local/controller.theme.dart';
import '../../../../controllers/project/controller.finishedProject.dart';
import '../../../../data/fonc.data.dart';
import '../../../../models/model.step.dart';

Widget stepFinishedProjectWidgetModel(int index) {
  final controller = Get.find<FinishedProjectController>();
  StepModel step = controller.project.steps[index];
  return Opacity(
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
  );
}
